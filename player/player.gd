class_name Player extends Node2D

@onready var sprite = $Sprite2D
@onready var camera = $PlayerCamera

signal change_patente(player, amount)
signal change_riesen(player, amount)

var patente: int:
	set(amount):
		if patente != amount:
			patente = amount
			change_patente.emit(self, amount)


var riesen: int:
	set(amount):
		if patente != amount:
			patente = amount
			change_patente.emit(self, amount)


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
	
	for event in current_location.driveby_events:
		event.call(self)

	var last = current_location
	current_location = await current_location.move_forwards(self)
	last_transversed = last

	if moves == 0:
		for event in current_location.field_events:
			event.call(self)
		register_duels()
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
		
		
func register_duels():
	current_location.field_events.append(duel)
	current_location.driveby_events.append(driveby_duel)
	
	
func duel(player: Player):
	print("Duel triggered")
	
	
func driveby_duel(player: Player):
	print("Drive-by Duel triggered")

