class_name QuestionsProvider extends JSONLoader

var file_path = "res://scripts/data/questions.json"
enum {EASY, NORMAL, DIFFICULT}
var questions = {EASY: [], NORMAL: [], DIFFICULT: []}
var current_question_index = -1;

func _init():
	var questions_from_json = load_json_file(file_path)["questions"]
	assert(questions_from_json != null, "No questions found.")
	for question in questions_from_json:
		var question_obj = Question.new()
		question_obj.question = question["question"]
		
		for answer_possibility in question["answer_possibilities"]:
			question_obj.answer_possibilities.append(answer_possibility)
			
		question_obj.right_answer = question["right_answer"]
		
		var difficulty = question["difficulty"]
		question_obj.difficulty = (difficulty)
		
		if(difficulty == 0):
			questions[EASY].append(question_obj)
		elif(difficulty == 1):
			questions[NORMAL].append(question_obj)
		elif(difficulty == 2):
			questions[DIFFICULT].append(question_obj)
		
func get_random_question(difficulty: int):
	return questions.get(difficulty)[randi() % questions[difficulty].size()].get_question()

func get_question(index: int, difficulty: int):
	return questions[difficulty][index]

func get_next_question(difficulty: int):
	if(current_question_index < questions[difficulty].size() - 1):
		current_question_index += 1
	else: 
		current_question_index = 0
	var question = get_question(current_question_index, difficulty)
	return question
	assert(question != null, "No question found.")
