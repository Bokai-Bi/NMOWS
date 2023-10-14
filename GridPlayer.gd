extends RigidBody2D


var frameCounter = 0  # Initialize a variable to keep track of the frame count.
var dir = 0
var pixelSize = 32
var numFrames = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	get_tree().call_group("killer", "set_player", self)

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

