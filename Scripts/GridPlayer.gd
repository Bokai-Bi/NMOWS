extends RigidBody2D

var frameCounter = 0  # Initialize a variable to keep track of the frame count.
var dir = 0
var pixelSize = 32
var numFrames = 60

var hiding = false
var visionBlockerSizeNormal = 0.3
var visionBlockerSizeHiding = 0.15
var visionBlockerSizeChangeSpeed = 0.0003
var visionBlocker
var popupText

var in_hiding_range
var preHideLocation
var hideLocation


var canMove

var velocity = Vector2()
var speed = 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	visionBlocker = get_node("VisionBlocker")
	popupText = get_node("Label")
	in_hiding_range = false
	canMove = true
	popupText.visible = false
	call_deferred("setPlayer")

func setPlayer():
	await get_tree().process_frame
	get_tree().call_group("killer", "set_player", self)

func _input(event):
	if event.is_action_pressed("interact"):
		if in_hiding_range and not hiding:
			hide_player()
		elif in_hiding_range and hiding:
			unhide_player()
	

func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("move_right"):
		dir = 0
		$AnimationPlayer.play("WalkRight")
		velocity.x += 1
	elif Input.is_action_pressed("move_left"):
		dir = 1
		$AnimationPlayer.play("WalkLeft")
		velocity.x -= 1
	elif Input.is_action_pressed("move_down"):
		dir = 2
		$AnimationPlayer.play("WalkDown")
		velocity.y += 1
	elif Input.is_action_pressed("move_up"):
		dir = 3
		$AnimationPlayer.play("WalkUp")
		velocity.y -= 1
	else:
		dir = 4
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	frameCounter += 1
	get_input()
	
	if !hiding:
		velocity = move_and_collide(velocity)
		
	if hiding:
		var currsize = visionBlocker.scale
		currsize.x = max(currsize.x - visionBlockerSizeChangeSpeed, visionBlockerSizeHiding)
		currsize.y = max(currsize.y - visionBlockerSizeChangeSpeed, visionBlockerSizeHiding)
		visionBlocker.scale = currsize
	else:
		var currsize = visionBlocker.scale
		currsize.x = min(currsize.x + visionBlockerSizeChangeSpeed, visionBlockerSizeNormal)
		currsize.y = min(currsize.y + visionBlockerSizeChangeSpeed, visionBlockerSizeNormal)
		visionBlocker.scale = currsize


func hide_player():
	get_node("CollisionShape2D").disabled = true
	preHideLocation = global_position
	global_position = hideLocation
	print("Transporting into hiding position")
	print(hideLocation)
	hiding = not hiding
	get_tree().call_group("killer", "set_hiding", hiding)
	# disable movement and rendering
	canMove = false
	get_node("Sprite2D").visible = false
	popupText.text = "Press E to unhide"

func unhide_player():
	get_node("CollisionShape2D").disabled = false
	global_position = Vector2(preHideLocation.x, preHideLocation.y)
	print("Transporting to Prehide:")
	print(Vector2(preHideLocation.x, preHideLocation.y))
	hiding = not hiding
	get_tree().call_group("killer", "set_hiding", hiding)
	# enable movement and rendering
	canMove = true
	get_node("Sprite2D").visible = true
	popupText.text = "Press E to hide"
	

func _on_interaction_range_body_entered(body):
	print("Entering")
	if (body.name.substr(0, 8) == "hideable"):
		print("EnteringHideable")
		in_hiding_range = true
		hideLocation = body.global_position
		popupText.visible = true
		popupText.text = "Press E to hide"
		
		


func _on_interaction_range_body_exited(body):
	print("Exiting")
	if (body.name.substr(0, 8) == "hideable"):
		print("ExitingHideable")
		in_hiding_range = false
		popupText.visible = false
		

func _integrate_forces(state):
	rotation = 0 # prevent player from rotating
