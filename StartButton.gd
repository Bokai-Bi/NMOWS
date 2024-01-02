extends Button




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_tree().change_scene_to_file("res://DialogueReal/Scenes/beginning_comic_scene.tscn")
	pass # Replace with function body.


func _on_button_down():
	pass # Replace with function body.
	##could just ADD a sprite here, it would be wonky tho
