extends Node2D

var animationPlayer

@export var play3Frame = false

func _ready():
	animationPlayer = $AnimationPlayer
	
func hide_animation():
	if play3Frame:
		animationPlayer.play("test_3frame")
	else:
		animationPlayer.play("test")
