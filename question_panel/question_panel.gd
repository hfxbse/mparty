extends CanvasLayer

var question: Question
var selected_answer

@onready var question_label = $MarginContainer/QuestionContainer/QuestionLabel
@onready var answer_container = $MarginContainer/QuestionContainer/AnswerContainer
@onready var question_container = $MarginContainer/QuestionContainer

signal answer_selected(answer: bool)



func display_question(difficulty):
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	
	question = question_handler.get_random_question(difficulty)
	question_label.set_text(question.question)

	for answer_possibility in question.answer_possibilities:
		var answer_button = create_answer_button(answer_possibility, _on_answer_selected)
		
		answer_container.add_child(answer_button)
	
	
	return answer_selected
	
	
func create_answer_button(answer, selected_receiver):
	var scene = preload("res://question_panel/answer_button.tscn")
	var answer_button = scene.instantiate()
	answer_button.button_text = answer

	answer_button.button_pressed.connect(selected_receiver)

	return answer_button


func _on_answer_selected(answer_text):
	selected_answer = answer_text
	print("Selected answer: " + answer_text)


func _on_submit_button_pressed():
	if selected_answer != null:
		var rightAnswer = question.answer_possibilities[question.right_answer]

		for child in answer_container.get_children():
			if child.button_text == rightAnswer:
				child._right_answer_selected()
			else:
				child._wrong_answer_selected()

		if rightAnswer == selected_answer:
			answer_selected.emit(true)
		else:
			answer_selected.emit(false)
		
		print("Submit current answer: " + selected_answer)
	else:
		if question_container.get_child_count() == 3:
			var error_label = Label.new()
			error_label.text = "Es wurde noch keine Antwort ausgewählt!"
			error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			error_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			
			question_container.add_child(error_label)
