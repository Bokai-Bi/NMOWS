extends Area2D

@export var target_scene = "res://DialogueReal/Scenes/level_2_dialogue_scene.tscn"

func _on_body_entered(body):
	if body.name == "GridPlayer":
		print("Go to Next Level")
		#get_tree().change_scene_to_file("res://DialogueReal/Scenes/level_1_dialogue_scene.tscn")
		get_tree().change_scene_to_file(target_scene)

