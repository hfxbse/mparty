class_name QuestionsProvider extends JSONLoader

var file_path = "res://data_providers/data/questions.json"
const difficulty_mapping = {
	"0": Question.Difficulty.EASY,
	"1": Question.Difficulty.NORMAL,
	"2": Question.Difficulty.DIFFICULT
}
var questions = {
	Question.Difficulty.EASY: [],
	Question.Difficulty.NORMAL: [],
	Question.Difficulty.DIFFICULT: []
}
var current_question_index = -1;

func _init():
	var questions_from_json = load_json_file(file_path)["questions"]
	assert(questions_from_json != null, "No questions found.")
	for question in questions_from_json:
		var question_obj = Question.new()
		var difficulty = difficulty_mapping[str(question["difficulty"])]
		assert(difficulty != null, "Difficulty \"%s\" is not supported." % difficulty)
		
		question_obj.question = question["question"]
		question_obj.answer_possibilities.assign(question["answer_possibilities"])
		question_obj.right_answer = question["right_answer"]
		question_obj.difficulty = difficulty
		
		questions[difficulty].append(question_obj)
		
func get_random_question(difficulty: Question.Difficulty):
	return get_question(randi() % questions[difficulty].size(), difficulty)

func get_question(index: int, difficulty: Question.Difficulty):
	return questions[difficulty][index]

func get_next_question(difficulty: Question.Difficulty):
	if(current_question_index < questions[difficulty].size() - 1):
		current_question_index += 1
	else: 
		current_question_index = 0
	var question = get_question(current_question_index, difficulty)
	assert(question != null, "No question found.")
	return question
