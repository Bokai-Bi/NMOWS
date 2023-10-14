extends RigidBody2D


var frameCounter = 0  # Initialize a variable to keep track of the frame count.
var dir = 0
var pixelSize = 32
var numFrames = 5

var hiding = false
var visionBlockerSizeNormal = 0.2
var visionBlockerSizeHiding = 0.1
var visionBlockerSizeChangeSpeed = 0.0003
var visionBlocker

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	get_tree().call_group("killer", "set_player", self)
	visionBlocker = get_node("VisionBlocker")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func movement_function():
	var direction = Vector2.ZERO

	if dir == 0: 
		$AnimationPlayer.play("WalkRight")
		direction.x += pixelSize
	if dir == 1:
		$AnimationPlayer.play("WalkLeft")
		direction.x -= pixelSize
	if dir == 2: 
		$AnimationPlayer.play("WalkDown")
		direction.y += pixelSize
	if dir == 3:
		$AnimationPlayer.play("WalkUp")
		direction.y -= pixelSize

	move_and_collide(direction)


func _process(delta):
	frameCounter += 1
	
	# Check if the frame counter has reached 5 (or any desired frame interval).
	if frameCounter >= numFrames:
		frameCounter = 0  # Reset the frame counter.
		movement_function()
	if Input.is_action_pressed("move_right"):
		dir = 0
	elif Input.is_action_pressed("move_left"):
		dir = 1
	elif Input.is_action_pressed("move_down"):
		dir = 2
	elif Input.is_action_pressed("move_up"):
		dir = 3
	else:
		dir = 4
		
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
	hiding = not hiding
	get_tree().call_group("killer", "set_hiding", hiding)



func _on_interaction_range_body_entered(body):
	if (body.name.substr(0, 8) == "hideable"):
		hide_player()
		


func _on_interaction_range_body_exited(body):
	if (body.name.substr(0, 8) == "hideable"):
		hide_player() # Replace with function body.
