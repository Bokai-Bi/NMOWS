extends RigidBody2D

var player = null
const MOVE_SPEED = 60


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("killer")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player == null:
		return
	var vec_to_player =  player.global_position - global_position
	vec_to_player = vec_to_player.normalized()
	print(vec_to_player)
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
	

func set_player(p):
	player = p
	print(player)
