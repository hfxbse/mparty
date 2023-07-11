extends Node

@export var field_theme_override : FieldTheme

func event(player : Player):
	var question_panel = preload("res://question_panel/question_panel.tscn").instantiate()
	add_child(question_panel)
	
	var result = await question_panel.display_question(Question.Difficulty.EASY)
	if result:
		print("right answer")
	else:
		print("wrong answer")
		
	await get_tree().create_timer(1.5).timeout
	remove_child(question_panel)
