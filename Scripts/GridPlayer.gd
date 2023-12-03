extends RigidBody2D

var frameCounter = 0  # Initialize a variable to keep track of the frame count.
var dir = 0
var pixelSize = 32
var numFrames = 60

#modded
var paused = false
var paused_times = 0
var hiding = false


var visionBlockerSizeNormal = 1.8	
var visionBlockerSizeHiding = 1
var visionBlockerSizeChangeSpeed = 0.003
var visionBlocker
var bloodSplatter
var baseBloodVisibility = 0
var popupText
var hideObject

var in_hiding_range
var preHideLocation
var hideLocation


var canMove

var velocity = Vector2()
var speed = 1

##sound stuff
var hit_knife := AudioStreamPlayer.new()
var steps := AudioStreamPlayer.new()
	
func doorLocked():
	popupText.visible = true
	popupText.text = "You need more keys"
	await get_tree().create_timer(1.0).timeout
	if popupText.text == "You need more keys":
		popupText.visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visionBlocker = get_node("VisionBlocker")
	bloodSplatter = get_node("BloodSplatter")
	popupText = get_node("Label")
	in_hiding_range = false
	canMove = true
	popupText.visible = false
	call_deferred("setPlayer")
	add_child(hit_knife)
	add_child(steps)

func setPlayer():
	await get_tree().process_frame
	get_tree().call_group("killer", "set_player", self)

func _input(event):
	if event.is_action_pressed("interact"):
		if in_hiding_range and not hiding:
			hide_player()
		elif in_hiding_range and hiding:
			unhide_player()
	
func pause_input():

	if Input.is_action_pressed("escape"):
			if paused == false:
				paused = true
				canMove = false

				get_tree().call_group("killer", "set_paused", paused)
				paused_times = paused_times + 1
			elif paused == true:
				paused = false
				canMove = true

				get_tree().call_group("killer", "set_paused", paused)		
				paused_times = paused_times + 1

	
	
func walk_sound():
	var sfx = load("res://Audio/Sound Effects/faster-footsteps-cut.mp3")
	steps.stream = sfx
	steps.play()
	
func get_input():
	velocity = Vector2()
	if canMove:
		if Input.is_action_pressed("move_right"):
			dir = 0
			$AnimationPlayer.play("WalkRight")
			velocity.x += 1
			walk_sound()
			
			#print("pressed right")
			
		elif Input.is_action_pressed("move_left"):
			dir = 1
			$AnimationPlayer.play("WalkLeft")
			velocity.x -= 1
			walk_sound()
		elif Input.is_action_pressed("move_down"):
			dir = 2
			$AnimationPlayer.play("WalkDown")
			velocity.y += 1
			walk_sound()
		elif Input.is_action_pressed("move_up"):
			dir = 3
			$AnimationPlayer.play("WalkUp")
			velocity.y -= 1
			walk_sound()
			
		else:
			dir = 4
		velocity = velocity.normalized() * speed

func _physics_process(delta):
	frameCounter += 1

	if paused_times < 1: 
		pause_input()
	else:
		paused_times = 0
		
		
	get_input()

	
	if !hiding:
		velocity = move_and_collide(velocity)
		
	bloodSplatter.modulate.a = max(bloodSplatter.modulate.a - 0.01, baseBloodVisibility)
		
	if hiding:
		var currsize = visionBlocker.scale
		currsize.x = max(currsize.x - visionBlockerSizeChangeSpeed*1.2, visionBlockerSizeHiding*1.2)
		currsize.y = max(currsize.y - visionBlockerSizeChangeSpeed, visionBlockerSizeHiding)
		visionBlocker.scale = currsize
	else:
		var currsize = visionBlocker.scale
		currsize.x = min(currsize.x + visionBlockerSizeChangeSpeed*1.2, visionBlockerSizeNormal*1.2)
		currsize.y = min(currsize.y + visionBlockerSizeChangeSpeed, visionBlockerSizeNormal)
		visionBlocker.scale = currsize


func hide_player():
	get_node("CollisionShape2D").disabled = true
	preHideLocation = global_position
	global_position = hideLocation
	hideObject.hide_animation()
	#print("Transporting into hiding position")
	#print(hideLocation)
	hiding = not hiding
	get_tree().call_group("killer", "set_hiding", hiding)
	# disable movement and rendering
	canMove = false
	get_node("Sprite2D").visible = false
	popupText.text = "Press E to unhide"

func unhide_player():
	get_node("CollisionShape2D").disabled = false
	global_position = Vector2(preHideLocation.x, preHideLocation.y)
	#print("Transporting to Prehide:")
	#print(Vector2(preHideLocation.x, preHideLocation.y))
	hiding = not hiding
	get_tree().call_group("killer", "set_hiding", hiding)
	# enable movement and rendering
	canMove = true
	get_node("Sprite2D").visible = true
	popupText.text = "Press E to hide"
	

func _on_interaction_range_body_entered(body):
	#print("Entering")
	if (body.name.substr(0, 8) == "hideable"):
		#print("EnteringHideable")
		in_hiding_range = true
		hideLocation = body.global_position
		popupText.visible = true
		popupText.text = "Press E to hide"
		hideObject = body
		

func setPopupText(t, v):
	popupText.text = t
	popupText.visible = v


func _on_interaction_range_body_exited(body):
	#print("Exiting")
	if (body.name.substr(0, 8) == "hideable"):
		#print("ExitingHideable")
		in_hiding_range = false
		popupText.visible = false

func _integrate_forces(state):
	rotation = 0 # prevent player from rotating

func display_blood(health):
	var sfx = load("res://Audio/Sound Effects/Slash Sound.mp3")
	hit_knife.stream = sfx
	hit_knife.play()
	bloodSplatter.modulate.a = 1
	baseBloodVisibility = (3 - health) * 0.15
