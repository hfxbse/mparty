extends CanvasLayer

# Called when the node enters the scene tree for the first time.


signal difficulty(diff: Question.Difficulty)

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_difficulty_1_pressed():
	difficulty.emit(Question.Difficulty.EASY)

func _on_difficulty_2_pressed():
	difficulty.emit(Question.Difficulty.NORMAL)

func _on_difficulty_3_pressed():
	difficulty.emit(Question.Difficulty.DIFFICULT)
