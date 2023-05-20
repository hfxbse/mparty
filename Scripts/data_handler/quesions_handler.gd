#Added QuestionHandler to the Autoloader in Project settings, so it is accessible globaly and only instantiated once
class_name QuestionsHandler extends Node

var file_path = "res://data/questions.json"
var json_loader = JSONLoader.new()
var questions: Array[Question]
var current_question_index = 0;

func _init():
	var questions_from_json = json_loader.load_json_file(file_path)["questions"]		
	for question in questions_from_json:
		var question_obj = Question.new()
		question_obj.set_question(question["question"])
		question_obj.set_answer_possibilities(question["answer_possibilities"])
		question_obj.set_right_answer(question["right_answer"])
		questions.append(question_obj)
		
func get_random_question():
	return questions[randi() % questions.size()].get_question()

func get_question(index: int):
	return questions[index]

func get_next_question():
	if(current_question_index < questions.size() - 1):
		current_question_index += 1
	else: 
		current_question_index = 0
	return get_question(current_question_index)
