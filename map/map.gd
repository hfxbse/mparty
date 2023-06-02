extends Node

var moves = 0
var player
var playerPath
var fieldReachedSignal

signal turn_ended

func get_start():
	return $Start

func move(newPlayerPath: NodePath, distance: int):
	playerPath = newPlayerPath
	player = get_node(newPlayerPath)
	moves = distance
	_move()

func _on_field_reached():
	fieldReachedSignal.disconnect(_on_field_reached)
	if moves == 0:
		turn_ended.emit()
		return
	_move()
	
func _move():
	moves -= 1
	var movementPath = player.currentLocation.path
	fieldReachedSignal = movementPath.move(playerPath)
	fieldReachedSignal.connect(_on_field_reached)
	
