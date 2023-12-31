extends Node2D

var animationPlayer

@export var play3Frame = false

func _ready():
	animationPlayer = $AnimationPlayer
	
func hide_animation():
	print("hehemeow...")
	animationPlayer.play("test")

func reset_animation():
	animationPlayer.play("RESET")

