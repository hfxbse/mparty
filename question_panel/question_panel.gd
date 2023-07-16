extends CanvasLayer

var question: Question
var selected_answer

@onready var question_label = $MarginContainer/QuestionContainer/QuestionLabel
@onready var answer_container = $MarginContainer/QuestionContainer/AnswerContainer
@onready var question_container = $MarginContainer/QuestionContainer

signal answer_selected(answer: bool)


func display_question(difficulty):
	var question_handler = preload("res://data_providers/question_provider/question_provider.tres")
	
	question = question_handler.get_random_question(difficulty)
	question_label.set_text(question.question)

	var answer_possibilities = question.answer_possibilities.duplicate()
	answer_possibilities.shuffle()

	for answer_possibility in answer_possibilities:
		var answer_button = create_answer_button(answer_possibility, _on_answer_selected)
		
		answer_container.add_child(answer_button)

	return answer_selected


func create_answer_button(answer, selected_receiver):
	var scene = preload("res://question_panel/answer_button.tscn")
	var answer_button = scene.instantiate()
	answer_button.button_text = answer
	answer_button.correct_answer = answer == question.right_answer

	answer_button.button_pressed.connect(selected_receiver)

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
