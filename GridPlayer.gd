extends RigidBody2D

@export var speed = 60
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	get_tree().call_group("killer", "set_player", self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	direction = direction.normalized() * speed * delta
	move_and_collide(direction)
