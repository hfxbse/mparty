class_name Question

var question: String
var answer_posibilities: Array[String]
var right_answer: int
var difficulty: int

func set_question(question_input: String):
	question = question_input
	
func set_answer_possibilities(answer_possibilities_input: Array):
	for answer in answer_possibilities_input: 
		answer_posibilities.append(str(answer))
	
func set_right_answer(right_answer_input: int):
	right_answer = right_answer_input

func set_difficulty(difficulty_input: int):
	difficulty = difficulty_input

func get_question():
	return question
	
func get_answer_possibilities():
	return answer_posibilities
	
func get_right_answer():
	return right_answer
	
func get_difficulty():
	return difficulty
	
