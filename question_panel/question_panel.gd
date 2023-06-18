extends VBoxContainer

var question: Question
var selected_answer
@onready var question_label = $QuestionLabel
@onready var answer_container = $AnswerContainer

func _ready():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	var counter = 0
	# Need to get difficulty from map
	question = question_handler.get_random_question(Question.Difficulty.EASY)
	question_label.set_text(question.question)
	
	for answer_possibility in question.answer_possibilities:
		var answer_button = create_answer_button(answer_possibility, _on_answer_selected, 5)
		
		if counter % 2 == 0:
			answer_container.get_child(0).add_child(answer_button)
		else:
			answer_container.get_child(1).add_child(answer_button)
		
		counter += 1
		
		
func create_answer_button(answer, selected_receiver, margin):
		var answer_button = AnswerButton.new(answer)
		var margin_container = MarginContainer.new()
		
		margin_container.add_theme_constant_override("margin_left", margin)
		margin_container.add_theme_constant_override("margin_right", margin)
		margin_container.add_theme_constant_override("margin_top", margin)
		margin_container.add_theme_constant_override("margin_bottom", margin)
		
		answer_button.answer_selected.connect(_on_answer_selected)
		
		margin_container.add_child(answer_button)
		
		return margin_container

		
func _on_answer_selected(answer_text):
	selected_answer = answer_text
	print("Selected answer: " + answer_text)


func _on_submit_button_pressed():
	print("Submit current answer: " + selected_answer)
