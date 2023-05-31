extends Node

var moves = 0
var player
var playerPath
var fieldReachedSignal

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
	if moves == 0:
		fieldReachedSignal.disconnect(_on_field_reached)
		return
	var movementPath = player.currentLocation.path
	movementPath.move(playerPath)
	moves -= 1
	
	
	
