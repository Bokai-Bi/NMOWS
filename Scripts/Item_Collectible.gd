# @tool makes it so that this code is run in the editor itself.
# so if we change the item_info it will change the texture of the sprite.
#@tool
extends Area2D

@export var item_info: Item_Info
"""
	set(value):
		# Set the texture of the attached Sprite2D to that specified in the item_info
		item_info = value
		if is_inside_tree():
			initialize()
"""
func _ready():
	initialize()

# Destroy item
func collect_item():
	queue_free()

func initialize():
	$Sprite2D.texture = item_info.texture
