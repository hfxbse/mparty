class_name Player extends Node2D

var moves = 0
var step_completed

var currentLocation
var lastLocation
var traversedFields = []
var TRAV_FIELDS_MAX_LENGTH = 20

signal turn_ended


func move(distance: int):
	lastLocation = currentLocation
	moves = distance
	_step()
	
func _step():
	moves -= 1
	step_completed = currentLocation.move(self)
	step_completed.connect(_on_step_completed)


func _on_step_completed(reached_field):
	step_completed.disconnect(_on_step_completed)
	
	currentLocation = reached_field
	registerMove(reached_field)
	
	if moves == 0:
		turn_ended.emit()
		return
		
	_step()


func registerMove(field):
		traversedFields.push_back(field)
		if traversedFields.size() > TRAV_FIELDS_MAX_LENGTH:
			traversedFields.pop_front()


func moveBackwards(n):
	for i in n:
		if traversedFields.size() <= 1: break
		currentLocation = traversedFields.pop_back()
		global_position = currentLocation.global_position
	currentLocation = traversedFields.back()
	global_position = currentLocation.global_position


func resetLastMove():
	while currentLocation != lastLocation:
		moveBackwards(1)
