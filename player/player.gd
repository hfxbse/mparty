class_name Player extends Node2D

@onready var sprite = $Sprite2D
@onready var camera = $PlayerCamera

var patente
signal change_patente(player, amount)

var riesen
signal change_riesen(player, amount)

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
	await step()
	
	
func step():
	moves -= 1

	var last = current_location
	current_location = await current_location.move_forwards(self)
	last_transversed = last

	if moves == 0:
		turn_ended.emit()
		return

	await step()


func move_backwards(n):
	for i in n:
		if not last_transversed:
			break

		var target = traversed_fields.pop_back()
		await target.move_backwards(self)


func undo_last_move():
	while last_transversed && current_location != last_location:
		await move_backwards(1)
		
		
func set_riesen(amount):
	self.riesen = amount
	change_riesen.emit(self, amount)
	
	
func set_patente(amount):
	self.patente = amount
	change_patente.emit(self, amount)
