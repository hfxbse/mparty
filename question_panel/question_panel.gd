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
		var answer_button = AnswerButton.new(answer_possibility)
		var button_margin_container = MarginContainer.new()
		var button_margin = 5
		
		button_margin_container.add_theme_constant_override("margin_left", button_margin)
		button_margin_container.add_theme_constant_override("margin_right", button_margin)
		button_margin_container.add_theme_constant_override("margin_top", button_margin)
		button_margin_container.add_theme_constant_override("margin_bottom", button_margin)
		
		answer_button.answer_selected.connect(_on_answer_selected)
		
		button_margin_container.add_child(answer_button)
		
		if counter % 2 == 0:
			answer_container.get_child(0).add_child(button_margin_container)
		else:
			answer_container.get_child(1).add_child(button_margin_container)
		
		counter += 1
		
		
func _on_answer_selected(answer_text):
	selected_answer = answer_text
	print("Selected answer: " + answer_text)


func _on_submit_button_pressed():
	print("Submit current answer: " + selected_answer)
