extends RigidBody2D

var player = null
var frameCounter = 0  # Initialize a variable to keep track of the frame count.
var pixelSize = 32
var numFrames = 0

var dirSwitchDelay = 1000
var currDir = Vector2(0,0)
var lastSwitch = 0

var playerHiding

var target_position = Vector2(0,0)

var movement_speed: float = 1
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("killer")
	$AnimationPlayer.play("Idle")
	playerHiding = false
	
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	navigation_agent.target_position = target_position

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = next_path_position - current_agent_position
	
	var move = changeDirAfterDelay(new_velocity)
	
	if(move.x < 0):
		$AnimationPlayer.play("WalkLeft")
	elif (move.x > 0):
		$AnimationPlayer.play("WalkRight")
	elif(move.y < 0):
		$AnimationPlayer.play("WalkUp")
	elif(move.y > 0):
		$AnimationPlayer.play("WalkDown")

	move = move.normalized() * movement_speed
	move_and_collide(move)

func changeDirAfterDelay(new_velocity):
	if (Time.get_ticks_msec() - lastSwitch < dirSwitchDelay):
		return currDir
		
	var move = Vector2(0,0)
	if(abs(new_velocity.x) > abs(new_velocity.y)):
		if(new_velocity.x < 0):
			move.x = -1
		else:
			move.x = 1
			
	else:
		if(new_velocity.y < 0):
			move.y = -1
		else:
			move.y = 1
			$AnimationPlayer.play("WalkDown")
	lastSwitch = Time.get_ticks_msec()
	currDir = move
	return currDir
	


func _process(delta):
	frameCounter += 1
	# Check if the frame counter has reached 5 (or any desired frame interval).
	#if frameCounter >= numFrames:
	if true:
		frameCounter = 0
		#update player position
		if player == null:
			print("Null player")
			return
		if playerHiding:
			return # change in the future
		else:
			target_position = player.global_position
			navigation_agent.target_position = target_position
			print("New target:")
			print(target_position)

	

func set_player(p):
	player = p
	print(player)
	
func set_hiding(hiding):
	playerHiding = hiding


func _on_area_2d_body_entered(body):
	if body.name == "GridPlayer":
		get_tree().change_scene_to_file("res://lose_screen.tscn")		
	pass # Replace with function body.
