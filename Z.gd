extends Node

# Dictionary to track how many of each item the player has
# key is name of item as string
# value is number of item held by the player
var items: Dictionary = {}

signal inventory_updated(_items: Dictionary)

# Add item specified by item_info to inventory
func add_item(item_info: Item_Info):
	# Add 1 to number of item held, or set to 1 if item isn't yet held
	items[item_info] = 1 + items[item_info] if items.has(item_info) else 1
	inventory_updated.emit(items)
	#print("Current inventory: ", get_item_list_as_string())

# Remove item specified by item_info from inventory
func remove_item(item_info: Item_Info):
	if items.has(item_info):
		# Erase key if only one of item is held. Otherwise, decrement number
		if items[item_info] == 1:
			items.erase(item_info)
		else:
			items[item_info] = items[item_info] - 1
		inventory_updated.emit(items)

func has_item(item_info: Item_Info) -> bool:
	return items.has(item_info)

'''
# Returns a list of the items in items as a String
func get_item_list_as_string() -> String:
	var item_list = "{ "
	for i in items:
		item_list += i.name + ", " + str(items[i]) + "; "
	item_list = item_list.trim_suffix("; ")
	item_list += " }"
	return item_list
'''
