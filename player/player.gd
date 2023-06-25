class_name Player extends Node2D

var moves = 0
var step_completed

var current_location
var last_location
var traversed_fields = []
const TRAV_FIELDS_MAX_LENGTH = 20

signal turn_ended


func move(distance: int):
	last_location = current_location
	moves = distance
	_step()
	
	
func _step():
	moves -= 1
	step_completed = current_location.move(self)
	step_completed.connect(_on_step_completed)


func _on_step_completed(reached_field):
	step_completed.disconnect(_on_step_completed)
	
	current_location = reached_field
	register_move(reached_field)
	
	if moves == 0:
		turn_ended.emit()
		return
		
	_step()


func register_move(field):
		traversed_fields.push_back(field)
		if traversed_fields.size() > TRAV_FIELDS_MAX_LENGTH:
			traversed_fields.pop_front()


func move_backwards(n):
	for i in n:
		if traversed_fields.size() <= 1: break
		current_location = traversed_fields.pop_back()
		global_position = current_location.global_position

	current_location = traversed_fields.back()
	global_position = current_location.global_position


func undo_last_move():
	while current_location != last_location:
		move_backwards(1)
