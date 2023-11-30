extends Node

var playerInRange = false
var player

var thisFound = false
var currExec = false

var findTimer = 3.0

func _input(event):
	if currExec or thisFound:
		if (thisFound and playerInRange and event.is_action_pressed("interact")):
			player.setPopupText("Already found the key here.", true)
			await get_tree().create_timer(1).timeout
			if player.popupText.text == "Already found the key here.":
				player.setPopupText("Already found the key here.", false)
		return
	currExec = true
	if event.is_action_pressed("interact") and playerInRange:
		var done = await lookForItem()
		if done:
			$"../Door".numKeyFound += 1
			thisFound = true
			player.setPopupText("Key found!", true)
			await get_tree().create_timer(1.5).timeout
			player.setPopupText("Key found!", false)
		else:
			player.setPopupText("Search interrupted", false)
	
	currExec = false
	
func lookForItem():
	player.setPopupText("Looking for key.", true)
	await get_tree().create_timer(findTimer/4).timeout
	if not playerInRange:
		return false
		
	player.setPopupText("Looking for key..", true)
	await get_tree().create_timer(findTimer/4).timeout
	if not playerInRange:
		return false
		
	player.setPopupText("Looking for key...", true)
	await get_tree().create_timer(findTimer/4).timeout
	if not playerInRange:
		return false
	
	player.setPopupText("Looking for key....", true)
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
