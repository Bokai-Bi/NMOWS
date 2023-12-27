extends Node

var playerInRange = false
var player

var thisFound = false
var currExec = false

var findTimer = 2.5

var diditOnce = false

var collected := AudioStreamPlayer.new()

@onready
var body = $KeyArea2D

func _ready():
	add_child(collected)


func _input(event):
	if currExec or thisFound:
		if (thisFound and playerInRange and event.is_action_pressed("interact")):
			player.setPopupText("Already found the key here.", true, Color.PALE_VIOLET_RED)
			await get_tree().create_timer(1).timeout
			if player.popupText.text == "Already found the key here.":
				player.setPopupText("Already found the key here.", false, Color.PALE_VIOLET_RED)
		return
	currExec = true
	if event.is_action_pressed("interact") and playerInRange:
		var done = await lookForItem()
		if done:
			$"../Door".numKeyFound += 1
			thisFound = true
			player.setPopupText("Key found!", true, Color.GREEN_YELLOW)
			var sfx = load("res://Audio/Sound Effects/Fun Button Sound (Collecting keys_).mp3")
			collected.stream = sfx
			collected.play()
			await get_tree().create_timer(1.5).timeout
			player.setPopupText("Key found!", false, Color.GREEN_YELLOW)
		else:
			player.setPopupText("Search interrupted", false, Color.PALE_VIOLET_RED)
	elif playerInRange:
		player.setPopupText("Press E to search", true, Color.AQUA)
		diditOnce = true
	elif diditOnce:
		if player.popupText.text == "Press E to search":
			player.setPopupText("Press E to search", false, Color.AQUA)
	
	currExec = false
	
func lookForItem():
	player.setPopupText("Looking for key.", true, Color.AQUAMARINE)
	await get_tree().create_timer(findTimer/4).timeout
	if not playerInRange:
		return false
		
	player.setPopupText("Looking for key..", true, Color.AQUAMARINE)
	await get_tree().create_timer(findTimer/4).timeout
	if not playerInRange:
		return false
		
	player.setPopupText("Looking for key...", true, Color.AQUAMARINE)
	await get_tree().create_timer(findTimer/4).timeout
	if not playerInRange:
		return false
	
	player.setPopupText("Looking for key....", true, Color.AQUAMARINE)
	await get_tree().create_timer(findTimer/4).timeout
	if not playerInRange:
		return false
	return true

func _on_area_2d_body_entered(body):
	if body.name == "GridPlayer":
		playerInRange = true
		player = body
		


func _on_area_2d_body_exited(body):
	if body.name == "GridPlayer":
		playerInRange = false
