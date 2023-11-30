extends StaticBody2D

var numKeyNeeded = 2
var numKeyFound = 0
	
func _on_area_2d_body_entered(body):
	if body.name == "GridPlayer":
		if numKeyFound < numKeyNeeded:
			body.doorLocked()
		elif numKeyFound == numKeyNeeded:
			visible = false
			process_mode = Node.PROCESS_MODE_DISABLED
		else:
			print("Something went wrong, had more key than needed")
		
