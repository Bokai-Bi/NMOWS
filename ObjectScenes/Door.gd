extends StaticBody2D

var locked = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_area_2d_body_entered(body):
	if body.name == "GridPlayer":
		if locked == true:
			body.doorLocked()
		if locked == false:
			visible = false
			body.hasKey = false
			process_mode = Node.PROCESS_MODE_DISABLED
		
