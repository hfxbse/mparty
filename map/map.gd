extends Node

var moves = 0
var player
var step_completed
var playerLocations = {}

signal turn_ended
@onready var start = $Start


func move(player: Player, distance: int):
	self.player = player
	playerLocations[player].lastLocation = playerLocations[player].currentLocation
	moves = distance
	_step()


func _on_step_completed(reached_field):
	step_completed.disconnect(_on_step_completed)
	
	playerLocations[player].currentLocation = reached_field
	playerLocations[player].registerMove(reached_field)
	
	if moves == 0:
		turn_ended.emit()
		return
		
	_step()


func moveBackwards(player: Player, distance: int):
	var field = playerLocations[player].moveBackwards(distance)
	player.global_position = field.global_position


func resetLastMove(player):
	var field = playerLocations[player].resetLastMove()
	player.global_position = field.global_position


func _step():
	moves -= 1
	step_completed = playerLocations[player].currentLocation.move(player)
	step_completed.connect(_on_step_completed)
	
	
func registerPlayer(player):
	playerLocations[player] = PlayerLocation.new()
	playerLocations[player].currentLocation = start
	playerLocations[player].registerMove(start)
	player.global_position = start.global_position
	
	
	
	
class PlayerLocation:
	var currentLocation
	var lastLocation
	var traversedFields = []
	const MAXLENGTH = 20
	
	
	func moveBackwards(n):
		for i in n:
			if traversedFields.size() <= 1: break
			currentLocation = traversedFields.pop_back();
		currentLocation = traversedFields.back()
		return currentLocation
		
		
	func resetLastMove():
		while currentLocation != lastLocation:
			moveBackwards(1)
		return currentLocation
			
			
	func registerMove(field):
		traversedFields.push_back(field)
		if traversedFields.size() > MAXLENGTH:
			traversedFields.pop_front()
		
		
	
	
