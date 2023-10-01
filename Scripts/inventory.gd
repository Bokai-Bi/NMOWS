extends Node

# Dictionary to track how many of each item the player has
# key is name of item as string
# value is number of item held by the player
var items = {}

# func _ready():

# func _process(delta):

# Add item specified by item_name to inventory
func add_item(item_name):
	# Add 1 to number of item held, or set to 1 if item isn't yet held
	items[item_name] = 1 + items[item_name] if items.has(item_name) else 1
	print("Item added to inventory: ", item_name)
	print("Current inventory: ", items)

# Remove item specified by item_name from inventory
func remove_item(item_name):
	if items.has(item_name):
		# Erase key if only one of item is held. Otherwise, decrement number
		if items[item_name] == 1:
			items.erase(item_name)
		else:
			items[item_name] = items[item_name] - 1
