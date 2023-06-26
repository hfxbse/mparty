class_name Player extends Node2D

var moves = 0

var current_location: Field
var last_location: Field
var traversed_fields: Array[Field] = []
const TRAV_FIELDS_MAX_LENGTH = 20

signal turn_ended


func move(distance: int):
	last_location = current_location
	moves = distance
	_step()
	
	
func _step():
	moves -= 1

	register_move(current_location)
	current_location = await current_location.move_forwards(self)

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
		if traversed_fields.is_empty():
			break

		var target = traversed_fields.pop_back()
		await target.move_backwards(self)


func undo_last_move():
	while current_location != last_location:
		await move_backwards(1)
