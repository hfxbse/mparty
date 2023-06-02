extends Node

var player
var map

func _init():
	var question_handler = preload("res://resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)
	print(question_handler.get_random_question(Question.Difficulty.EASY).question)
	
func _ready():
	player = $Player
	map = $Map
	player.currentLocation = map.get_start()

func _on_button_pressed():
	map.move("/root/Node/Player", 2)

func _process(delta):
	pass
