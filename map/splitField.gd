extends "res://map/field.gd"

@onready var path2 = $Path2

signal path_picked
signal path2_picked
signal step_completed

var path_ended
var playerPath

func move(player: NodePath):
	playerPath = player
	path_picked.connect(_on_path_picked)
	path2_picked.connect(_on_path2_picked)
	path.target.button.activate(path_picked)
	path2.target.button.activate(path2_picked)
	return step_completed

func _cleanUp():
	path2_picked.disconnect(_on_path2_picked)	
	path_picked.disconnect(_on_path_picked)
	path.target.button.deactivate()
	path2.target.button.deactivate()

func _on_path_picked():
	_cleanUp()
	path_ended = path.move(playerPath)
	path_ended.connect(_on_path_ended)
	
	
func _on_path2_picked():
	_cleanUp()
	path_ended = path2.move(playerPath)
	path_ended.connect(_on_path_ended)
	
func _on_path_ended():
	path_ended.disconnect(_on_path_ended)
	step_completed.emit()
