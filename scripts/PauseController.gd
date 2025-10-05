extends Node

func _input(event):
	if event.is_action_pressed("pause_game"):
		get_tree().paused = not get_tree().paused
