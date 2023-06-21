extends Node

@onready var player = $Player
@onready var map = $Map
@onready var button = $Button


func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)
	print(question_handler.get_random_question(Question.Difficulty.EASY).question)
	
func _ready():
	player.currentLocation = map.start

func _on_button_pressed():
	button.hide()
	map.move(player, 3)

func _on_map_turn_ended():
	button.show()
