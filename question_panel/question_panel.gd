extends CanvasLayer

var question: Question
var selected_answer

@onready var question_label = $MarginContainer/QuestionContainer/QuestionLabel
@onready var answer_container = $MarginContainer/QuestionContainer/AnswerContainer
@onready var question_container = $MarginContainer/QuestionContainer

@export var player_name: String = "":
	set(text):
		if player_name != text:
			player_name = text
			
			if question_label:
				question_label.text = text + ": " + question_label.text

signal answer_selected(answer: bool)


func display_question(difficulty):
	var question_provider = preload("res://data_providers/question_provider/question_provider.tres")
	return display_specific_question(question_provider.get_random_question(difficulty))


func display_specific_question(question: Question):
	self.question = question
	
	question_label.text = question_label.text + question.question

	var answer_possibilities = question.answer_possibilities.duplicate()
	answer_possibilities.shuffle()

	for answer_possibility in answer_possibilities:
		var answer_button = create_answer_button(answer_possibility)
		answer_button.button_pressed.connect(_on_answer_selected)
		answer_container.add_child(answer_button)

	return answer_selected


func create_answer_button(answer):
	var scene = preload("res://question_panel/answer_button.tscn")
	var answer_button = scene.instantiate()
	answer_button.button_text = answer
	answer_button.correct_answer = answer == question.right_answer

	return answer_button


func _on_answer_selected(answer_text):
	selected_answer = answer_text


func _on_submit_button_pressed():
	if selected_answer != null:
		for button in answer_container.get_children():
			button.reveal()

		if question.right_answer == selected_answer:
			answer_selected.emit(true)
		else:
			answer_selected.emit(false)
	else:
		if question_container.get_child_count() == 3:
			var error_label = Label.new()
			error_label.text = "Es wurde noch keine Antwort ausgewählt!"
			error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			error_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			
			question_container.add_child(error_label)
