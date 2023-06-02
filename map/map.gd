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
	var movementPath = player.currentLocation.path
	moves = distance - 1
	fieldReachedSignal = movementPath.move(playerPath)
	fieldReachedSignal.connect(_on_field_reached)

func _on_field_reached():
	fieldReachedSignal.disconnect(_on_field_reached)
	if moves == 0:
		turn_ended.emit()
		return
	var movementPath = player.currentLocation.path
	fieldReachedSignal = movementPath.move(playerPath)
	fieldReachedSignal.connect(_on_field_reached)
	moves -= 1
	
	
	
