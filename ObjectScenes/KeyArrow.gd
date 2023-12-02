extends Sprite2D

var keys = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# Find all nodes named 'Key' in the scene and add them to the keys array
	var root = get_tree().get_root()
	_find_keys(root)

# Recursive function to find all keys in the scene
func _find_keys(node):
	for child in node.get_children():
		if child.name == "Key":
			keys.append(child)
		_find_keys(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var closest_key = _find_closest_key()
	if closest_key:
		_rotate_towards(closest_key.global_position)

# Find the closest key
func _find_closest_key():
	var closest_key = null
	var min_distance = INF
	for key in keys:
		var distance = global_position.distance_to(key.global_position)
		if distance < min_distance:
			min_distance = distance
			closest_key = key
	return closest_key

# Rotate the sprite towards a position
func _rotate_towards(position):
	var direction = position - global_position
	rotation = atan2(direction.y, direction.x)
