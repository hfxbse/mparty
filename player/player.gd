class_name Player extends Node2D

var moves = 0
var current_location: Field
var last_location: Field

signal turn_ended

const TRAV_FIELDS_MAX_LENGTH = 20
var traversed_fields: Array[Field] = []
var last_transversed: Field:
	set(field):
		if last_transversed != field:
			traversed_fields.push_back(field)

			if traversed_fields.size() > TRAV_FIELDS_MAX_LENGTH:
				traversed_fields.pop_front()
	get:
		if traversed_fields.is_empty():
			return null
		else:
			return traversed_fields[-1]


func move(distance: int):
	last_location = current_location
	moves = distance
	step()


func step():
	moves -= 1

	var last = current_location
	current_location = await current_location.move_forwards(self)
	last_transversed = last

	if moves == 0:
		turn_ended.emit()
		return

	step()


func move_backwards(n):
	for i in n:
		if not last_transversed:
			break

		var target = traversed_fields.pop_back()
		await target.move_backwards(self)


func undo_last_move():
	while last_transversed && current_location != last_location:
		await move_backwards(1)
