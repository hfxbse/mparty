extends Node

func _init():
	var event_handler = load("res://resources/event_handler.tres")
	var question_handler = load("res://resources/question_handler.tres")
	print(question_handler.get_next_question(0).get_question())
	print(event_handler.get_event(0).get_event_description())

func _ready():
	pass


func _process(delta):
	pass
