extends Node

@export var field_theme_override : FieldTheme

func event(player : Player):
	var question_difficulty = preload("res://question_difficulty/question_difficulty.tscn").instantiate()
	add_child(question_difficulty)

	var difficulty = await question_difficulty.difficulty
	remove_child(question_difficulty)

	var question_panel = preload("res://question_panel/question_panel.tscn").instantiate()
	add_child(question_panel)

	if await question_panel.display_question(difficulty):
		player.riesen += 20 * (difficulty + 1)

	await get_tree().create_timer(1.5).timeout
	remove_child(question_panel)
