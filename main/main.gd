extends Node

var player
var map

func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	
func _ready():
	player = $Player
	map = $Map
	player.currentLocation = map.get_start()

func _on_button_pressed():
	$Button.hide()
	map.move("/root/Node/Player", 3)

func _on_map_turn_ended():
	$Button.show()
