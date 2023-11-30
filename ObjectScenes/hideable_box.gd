extends Node2D

var animationPlayer

func _ready():
	animationPlayer = $AnimationPlayer
	
func hide_animation():
	animationPlayer.play("test")
