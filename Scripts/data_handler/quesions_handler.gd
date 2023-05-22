class_name QuestionsHandler extends Resource

var file_path = "res://Scripts/data/questions.json"
var json_loader = JSONLoader.new()
#0: easy, 1: normal, 2: difficult
var questions = {0: [], 1: [], 2: []}
var current_question_index = -1;

func _init():
	var questions_from_json = json_loader.load_json_file(file_path)["questions"]		
	if(questions_from_json != null):
		for question in questions_from_json:
			var question_obj = Question.new()
			question_obj.set_question(question["question"])
			question_obj.set_answer_possibilities(question["answer_possibilities"])
			question_obj.set_right_answer(question["right_answer"])
			var difficulty = question["difficulty"]
			question_obj.set_difficulty(difficulty)
			questions[int(difficulty)].append(question_obj)
	else:
		print("Couldn't load questions.")
		
func get_random_question(difficulty: int):
	return questions.get(difficulty)[randi() % questions[difficulty].size()].get_question()

func get_question(index: int, difficulty: int):
	if(index >= 0 and index < questions.size()):
		return questions.get(difficulty)[index]
	else:
		print("Question index out of bounds.")
		return null

func get_next_question(difficulty: int):
	if(current_question_index < questions.get(difficulty).size() - 1):
		current_question_index += 1
	else: 
		current_question_index = 0
	var question = get_question(current_question_index, difficulty)
	if(question != null):
		return question
	else:
		print("No next question found.")
