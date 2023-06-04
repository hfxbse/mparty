extends Node

@onready var player: Player = $Player
@onready var map = $Map
@onready var MoveButton = $MoveButton


signal turn_start()

func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)
	print(question_handler.get_random_question(Question.Difficulty.EASY).question)


func _ready():
	var start = map.start
	player.current_location = start
	player.global_position = start.global_position


func _on_button_pressed():
	MoveButton.hide()
	player.move(2)


func _on_player_turn_ended():
	MoveButton.show()


func _on_back_button_pressed():
	player.move_backwards(1)


func _on_undo_button_pressed():
	player.undo_last_move()
