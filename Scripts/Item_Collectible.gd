extends Area2D

@export var item_name : String

signal picked_up(_item_name)

var is_overlapping_player : bool

# func _ready():

func _process(delta):
	if Input.is_action_just_pressed("interact") && is_overlapping_player:
			picked_up.emit(item_name)
			queue_free()

# If colliding with player, connect signal for adding to inventory
func _on_body_entered(body):
	if body.name == "Player":
		is_overlapping_player = true
		var player_inventory = body.get_node("Inventory")
		connect("picked_up", player_inventory.add_item)

# If exiting collision with player, disconnect signal for adding to inventory
func _on_body_exited(body):
	if body.name == "Player":
		is_overlapping_player = false
		var player_inventory = body.get_node("Inventory")
		disconnect("picked_up", player_inventory.add_item)
