extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("keys")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_keynum(num):
	if (num > 1):
		visible = true
