extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

	
	
	


func _on_area_2d_body_entered(body):
	if body.name == "GridPlayer":
		var door = $"../Door"
		var key = $"../Key"
		if (key.visible == true):
			door.locked = false
			door.visible = true
			body.keyAcquired()
			key.visible = false
		
