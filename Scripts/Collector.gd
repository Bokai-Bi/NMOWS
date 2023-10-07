extends Area2D

# the Inventory the Collector adds items to
@export var inventory: Node
# the group that items collectible by this Collector are in
@export var collectible_group: String

# collect any collectibles overlapping collector's area
func collect_items_if_any():
	for area in get_overlapping_areas():
		if area.is_in_group(collectible_group):
			inventory.add_item(area.item_info)
			area.collect_item()
