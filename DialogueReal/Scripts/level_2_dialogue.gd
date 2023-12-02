extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_dialog = Dialogic.start('level_2')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Dialogic.VAR.nextScene == true:
		Dialogic.VAR.nextScene = false
		Dialogic.VAR.nextLevel = 3
		get_tree().change_scene_to_file("res://transition_scene.tscn")
	pass
