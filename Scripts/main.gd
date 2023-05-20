extends Node

func _init():
	print(QuesionsHandler.get_next_question().get_question())
	print(EventsHandler.get_event(0).get_event_description())

func _ready():
	pass


func _process(delta):
	pass
