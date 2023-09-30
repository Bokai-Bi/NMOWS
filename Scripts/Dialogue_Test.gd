extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_dialog = Dialogic.start('TestSequence', false)
	add_child(new_dialog)
	
	# TODO connect signals when dialogue ends
	# new_dialog.connect("timeline_end", self, 'after_dialog')
	
func after_dialog(timeline_name):
	print ('RESUME THE GAME?!')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
