extends VBoxContainer

var question: Question
var selected_answer

@onready var question_label = $QuestionLabel
@onready var answer_container = $AnswerContainer


func _ready():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	# Need to get difficulty from map
	question = question_handler.get_random_question(Question.Difficulty.EASY)
	question_label.set_text(question.question)

	for answer_possibility in question.answer_possibilities:
		var answer_button = create_answer_button(answer_possibility, _on_answer_selected)
		
		answer_container.add_child(answer_button)


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
	print("Submit current answer: " + selected_answer)
