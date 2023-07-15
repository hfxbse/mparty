extends CanvasLayer

signal difficulty(diff: Question.Difficulty)


func _on_difficulty_1_pressed():
	difficulty.emit(Question.Difficulty.EASY)


func _on_difficulty_2_pressed():
	difficulty.emit(Question.Difficulty.NORMAL)


func _on_difficulty_3_pressed():
	difficulty.emit(Question.Difficulty.DIFFICULT)
