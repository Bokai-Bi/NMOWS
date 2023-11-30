extends StaticBody2D

var numKeyNeeded = 2
var numKeyFound = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_area_2d_body_entered(body):
	if body.name == "GridPlayer":
		if numKeyFound < numKeyNeeded:
			body.doorLocked()
		elif numKeyFound == numKeyNeeded:
			visible = false
			process_mode = Node.PROCESS_MODE_DISABLED
		else:
			print("Something went wrong, had more key than needed")
		
