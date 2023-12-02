extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2).timeout
	if Dialogic.VAR.nextLevel == 2:
		get_tree().change_scene_to_file("res://dormhall_tilemap.tscn")
	elif Dialogic.VAR.nextLevel == 3:
		get_tree().change_scene_to_file("res://naturelab_tilemap.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
