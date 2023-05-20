#Added QuestionHandler to the Autoloader in Project settings, so it is accessible globaly and only instantiated once
class_name QuestionsHandler extends Node

var file_path = "res://data/questions.json"
var json_loader = JSONLoader.new()
var questions: Array[Question]
var current_question_index = 0;

func _init():
	var questions_from_json = json_loader.load_json_file(file_path)["questions"]		
	if(questions_from_json != null):
		for question in questions_from_json:
			var question_obj = Question.new()
			question_obj.set_question(question["question"])
			question_obj.set_answer_possibilities(question["answer_possibilities"])
			question_obj.set_right_answer(question["right_answer"])
			questions.append(question_obj)
	else:
		print("Couldn't load questions.")
		
func get_random_question():
	return questions[randi() % questions.size()].get_question()

func get_question(index: int):
	if(index > 0 and index < questions.size()):
		return questions[index]
	else:
		print("Question index out of bounds.")
		return null

func get_next_question():
	if(current_question_index < questions.size() - 1):
		current_question_index += 1
	else: 
		current_question_index = 0
	var question = get_question(current_question_index)
	if(question != null):
		return question
	else:
		print("No next question found.")
