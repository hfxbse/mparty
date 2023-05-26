extends Node

var moves = 0
var currentPlayer
var currentPlayerPath
var currentPath

func get_start():
	return $Start.get_path()

func move(playerPath: NodePath, distance: int):
	_setup_move(playerPath, distance)
	moves -= 1
	currentPath.move(currentPlayerPath).connect(_on_field_reached)

func _setup_move(playerPath: NodePath, distance: int):
	currentPlayerPath = playerPath
	currentPlayer = get_node(currentPlayerPath)
	currentPath = get_node(currentPlayer.current_location).path
	moves = distance

func _on_field_reached():
	if moves == 0:
		return
	currentPath.move(currentPlayerPath)
	moves -= 1
	
	
	
