extends Node

var player
var map

func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)
	print(question_handler.get_random_question(Question.Difficulty.EASY).question)
	
func _ready():
	player = $Player
	map = $Map
	player.currentLocation = map.get_start()

func _on_button_pressed():
	$Button.hide()
	map.move("/root/Node/Player", 3)

func _on_map_turn_ended():
	$Button.show()
