class_name Event

var event_description: String
var question: Question

func set_event_description(event_description_input: String):
	event_description = event_description_input
	
func set_question(question_input: Question):
	question = question_input

func get_event_description():
	return event_description

func get_question():
	return question

#TODO default action
func action():
	pass
