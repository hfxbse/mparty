extends Node

var moves = 0
var player
var step_completed

signal turn_ended
@onready var start = $Start

func move(player: Player, distance: int):
	self.player = player
	moves = distance
	_step()

func _on_step_completed():
	step_completed.disconnect(_on_step_completed)
	
	if moves == 0:
		turn_ended.emit()
		return
		
	_step()
	
func _step():
	moves -= 1
	step_completed = player.currentLocation.move(player.get_path())
	step_completed.connect(_on_step_completed)
	
