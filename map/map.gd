extends Node

var moves = 0
var player
var playerPath
var step_completed

signal turn_ended

func get_start():
	return $Start

func move(newPlayerPath: NodePath, distance: int):
	playerPath = newPlayerPath
	player = get_node(newPlayerPath)
	moves = distance
	_move()

func _on_step_completed():
	step_completed.disconnect(_on_step_completed)
	if moves == 0:
		turn_ended.emit()
		return
	_move()
	
func _move():
	moves -= 1
	var playerLocation = player.currentLocation
	step_completed = playerLocation.move(playerPath)
	step_completed.connect(_on_step_completed)
	
