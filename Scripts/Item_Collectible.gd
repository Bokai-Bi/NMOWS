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
	print("collection trigger ")
	queue_free()
	
func _on_body_entered(e):
	print(e)
	print("well THAT just happened")
	
func _on_body_exited(e):
	print(e)
	print("well THAT just unhappened")
	

func initialize():
	$Sprite2D.texture = item_info.texture

