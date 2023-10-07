extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player":
		var door = $"../Door"
		door.process_mode = Node.PROCESS_MODE_DISABLED
		door.visible = false
		$"../Key".visible = false
	
	
	
