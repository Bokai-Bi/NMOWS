extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "GridPlayer":
		print("Go to Next Level")
		get_tree().change_scene_to_file("res://DialogueReal/Scenes/level_1_dialogue_scene.tscn")

#func _on_body_entered(body):
	if body.name == "GridPlayer":
		print("Go to Next Level")
		get_tree().change_scene_to_file("res://DialogueReal/Scenes/level_1_dialogue_scene.tscn")
