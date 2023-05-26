extends Node

func _init():
	var question_handler = preload("res://resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)

func _ready():
	pass


func _process(delta):
	pass
