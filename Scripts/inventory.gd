extends Node

# Dictionary to track how many of each item the player has
# key is name of item as string
# value is number of item held by the player
var items = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Add item specified by item_name to inventory
func add_item(item_name):
	# Add 1 to number of item held, or set to 1 if item isn't yet held
	items[item_name] = 1 + items[item_name] if items.has(item_name) else 1

func remove_item(item_name):
	if items.has(item_name):
		# Erase key if only one of item is held. Otherwise, decrement number.
		if items[item_name] == 1:
			items.erase(item_name)
		else:
			items[item_name] = items[item_name] - 1
