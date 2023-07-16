class_name Player extends Node2D

@onready var sprite = $Sprite2D
@onready var camera = $PlayerCamera

signal update

var skip = false

var sabotage_card = 0

var player_name: String


var patente: int:
	set(amount):
		if patente != amount:
			patente = amount
			update.emit()


var riesen: int:
	set(amount):
		if riesen != amount:
			riesen = max(0, amount)
			update.emit()


var moves = 0

var current_location: Field
var last_location: Field
var duel_panel

signal turn_ended

const TRAV_FIELDS_MAX_LENGTH = 20
var traversed_fields: Array[Field] = []
var last_traversed: Field:
	set(field):
		if last_traversed != field:
			traversed_fields.push_back(field)

			if traversed_fields.size() > TRAV_FIELDS_MAX_LENGTH:
				traversed_fields.pop_front()
	get:
		if traversed_fields.is_empty():
			return null
		else:
			return traversed_fields[-1]


func move(distance: int):
	unregister_duels()
	last_location = current_location
	moves = distance
	await step()
	register_duels()


func step():
	moves -= 1
	var last = current_location
	current_location = await current_location.move_forwards(self)
	last_traversed = last

	if moves == 0:
		for event in current_location.field_events:
			await event.call(self)
		turn_ended.emit()
		return
	
	for event in current_location.driveby_events:
		await event.call(self)
	
	await step()


func move_backwards(n):
	unregister_duels()
	for i in n:
		if not last_traversed:
			break

		var target = traversed_fields.pop_back()
		await target.move_backwards(self)
	register_duels()


func undo_last_move():
	while last_traversed && current_location != last_location:
		await move_backwards(1)
		
		
func unregister_duels():
	current_location.field_events.erase(duel)
	current_location.driveby_events.erase(driveby_duel)


func teleport(target: Field):
	unregister_duels()
	traversed_fields = []
	last_location = null
	current_location = target
	global_position = target.global_position
	
	for event in current_location.field_events:
		await event.call(self)
	register_duels()
		
		
func swap_with(player: Player):
	unregister_duels()
	player.unregister_duels()
	
	var tmp_field = current_location
	
	teleport(player.current_location)
	player.teleport(tmp_field)

		
func register_duels():
	current_location.field_events.append(duel)
	current_location.driveby_events.append(driveby_duel)
	
	
func duel(player: Player):
	duel_panel = preload("res://duel/same_field_duel.tscn").instantiate()
	add_child(duel_panel)
	var result = await duel_panel.start_duel(player, self)
	apply_duel_outcome(player, min(self.riesen, player.riesen) / 2, result)
	
	
func driveby_duel(player: Player):
	duel_panel = preload("res://duel/overtaking_duell.tscn").instantiate()
	add_child(duel_panel)
	var result = await duel_panel.start_duel(player, self)
	apply_duel_outcome(player, 30, result)
			
func apply_duel_outcome(other_player: Player, bet_amount: int, result):
	if result == Duel.DuelEndings.ATTACKER_LOSES:
		bet_amount *= -1
	elif result == Duel.DuelEndings.DRAW:
		bet_amount *= 0
	
	self.riesen -= bet_amount
	other_player.riesen += bet_amount
