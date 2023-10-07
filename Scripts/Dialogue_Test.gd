extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	var new_dialog = Dialogic.start('TestSequence')
	#add_child(new_dialog)
	
	# TODO connect signals when dialogue ends
	# new_dialog.connect("timeline_end", self, 'after_dialog')
	#new_dialog.timeline_end.connect(self.after_dialog)
	#new_dialog.dialogic_signal.connect(self.dialogic_signal)
	
func after_dialog(timeline_name):
	print ('RESUME THE GAME?!')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta):
	pass

func dialogic_signal(argument):
	print(GlobalData.successfulRizzes)
	print(GlobalData.failedRizzes)
	if argument == 'goodChoice':
		GlobalData.successfulRizzes += 1
	if argument == 'badChoice':
		GlobalData.failedRizzes += 1
	print(GlobalData.successfulRizzes)
	print(GlobalData.failedRizzes)
