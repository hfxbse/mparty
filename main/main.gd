extends Node

@onready var player = $Player
@onready var map = $Map
@onready var MoveButton = $MoveButton


func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)
	print(question_handler.get_random_question(Question.Difficulty.EASY).question)
	
func _ready():
	var start = map.start
	player.currentLocation = start
	player.global_position = start.global_position
	player.traversedFields = [start]

func _on_button_pressed():
	MoveButton.hide()
	player.move(2)

func _on_player_turn_ended():
	MoveButton.show()

func _on_back_button_pressed():
	player.moveBackwards(1)

func _on_reset_button_pressed():
	player.resetLastMove()
