extends Control

var question: Question
var selected_answer

@onready var question_label = $MarginContainer/QuestionContainer/QuestionLabel
@onready var answer_container = $MarginContainer/QuestionContainer/AnswerContainer

signal answer_selected(answer: bool)


func display_question(difficulty):
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	
	question = question_handler.get_random_question(difficulty)
	question_label.set_text(question.question)

	for answer_possibility in question.answer_possibilities:
		var answer_button = create_answer_button(answer_possibility, _on_answer_selected)
		
		answer_container.add_child(answer_button)
	
	
	return answer_selected
	
"res://question_panel/question_panel.gd"
func create_answer_button(answer, selected_receiver):
	var scene = preload("res://question_panel/answer_button.tscn")
	var answer_button = scene.instantiate()
	answer_button.button_text = answer

	answer_button.answer_selected.connect(selected_receiver)

	return answer_button


func _on_answer_selected(answer_text):
	selected_answer = answer_text
	print("Selected answer: " + answer_text)


func _on_submit_button_pressed():
	if question.right_answer == question.answer_possibilities.find(selected_answer):
		answer_selected.emit(true)
	else:
		answer_selected.emit(false)
		
	print("Submit current answer: " + selected_answer)
