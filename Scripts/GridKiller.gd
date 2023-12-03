extends RigidBody2D

var player = null
var frameCounter = 0  # Initialize a variable to keep track of the frame count.
var pixelSize = 32
var numFrames = 0

var health = 3
var player_collided = false

var dirSwitchDelay = 100
var currDir = Vector2(0,0)
var lastSwitch = 0

var playerHiding
var playerPaused

var target_position = Vector2(0,0)

var invincibility = false
var invincibilityTime = 1.5


var killerBaseSpeed = 1.55
var playerBaseSpeed = 1.5
var killerSlowSpeed = 0.7 # speed after hitting player
var playerFastSpeed = 2 # speed after getting hit
var movement_speed: float = killerBaseSpeed

var lastFoundDest
var findDestDelay = 1000

var random = RandomNumberGenerator.new()

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var collider: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("killer")
	$AnimationPlayer.play("Idle")
	playerHiding = false
	playerPaused = false
	
	random.randomize()
	
	lastFoundDest = Time.get_ticks_msec()
	
	navigation_agent.path_desired_distance = 8.0
	navigation_agent.target_desired_distance = 8.0

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
	
	if(!playerPaused):
		if(move.x < 0):
			$AnimationPlayer.play("WalkLeft")
		elif (move.x > 0):
			$AnimationPlayer.play("WalkRight")
		elif(move.y < 0):
			$AnimationPlayer.play("WalkUp")
		elif(move.y > 0):
			$AnimationPlayer.play("WalkDown")
		
	#print(move.normalized())
		move = move.normalized() * movement_speed
		move_and_collide(move)
	

func check_collision(dir):
	# Check if the given shape will intersect with any other shape
	var params = PhysicsShapeQueryParameters2D.new()
	var collider_transform = collider.transform
	collider_transform.origin.x += dir.x * movement_speed
	collider_transform.origin.y += dir.y * movement_speed
	#params.shape = collider_transform
	#params.shape = collider_transform.shape

	return get_world_2d().direct_space_state.intersect_shape(params)
		

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
			#$AnimationPlayer.play("WalkDown")
	lastSwitch = Time.get_ticks_msec()
	currDir = move
	return currDir
	

var alreadyFound = false
func _process(delta):
	frameCounter += 1
	# Check if the frame counter has reached 5 (or any desired frame interval).
	#if frameCounter >= numFrames:
	if true:
		#update player position
		if player == null:
			print("Null player")
			return
		if playerHiding:
			
			if frameCounter < 500:
				return
			alreadyFound = false
			target_position = player.global_position
			target_position.x += random.randi_range(-300, 300)
			target_position.y += random.randi_range(-300, 300)
			navigation_agent.target_position = target_position
			frameCounter = 0
		else:
			if not alreadyFound: 
				tempDecreaseSpeed(4)
				alreadyFound = true
			target_position = player.global_position
			navigation_agent.target_position = target_position
			frameCounter = 0
			

func tempDecreaseSpeed(seconds):
	movement_speed = killerSlowSpeed
	await get_tree().create_timer(seconds).timeout
	movement_speed = killerBaseSpeed
	

func set_player(p):
	player = p
	player.speed = playerBaseSpeed
	
func set_hiding(hiding):
	playerHiding = hiding
	
func set_paused(paused):
	playerPaused = paused
	print(playerPaused)



func _on_area_2d_body_entered(body):
	if body.name == "GridPlayer" and not invincibility:
		player_collided = true
		player_collision_timer()
		health -= 1
		movement_speed = killerSlowSpeed
		player.display_blood(health)
		player.speed = playerFastSpeed
		invincibility = true
		
	if body.name == "GridPlayer" && health <= 0:
		get_tree().change_scene_to_file("res://lose_screen.tscn")		
	pass # Replace with function body.
	
#func _on_area_2d_body_exited(body):
	

func player_collision_timer():
	while (player_collided == true):
		await get_tree().create_timer(invincibilityTime).timeout
		invincibility = false
		if (player_collided == true):
			health -= 1
			player.speed = playerFastSpeed
			movement_speed = killerSlowSpeed
			player.display_blood(health)
			if health <= 0:
				get_tree().change_scene_to_file("res://lose_screen.tscn")	
			invincibility = true	
		else:
			player.speed = playerBaseSpeed
			movement_speed = killerBaseSpeed
	pass # Replace with function body.


func _on_interaction_range_body_exited(body):
	if body.name == "GridPlayer":
		player_collided = false
