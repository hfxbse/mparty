extends Node

var player
var map

func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	
func _ready():
	player = $Player
	map = $Map
	player.currentLocation = map.get_start()
	var question_difficulty_menu = preload("res://fieldActions/questionDifficulty/questionDifficulty.tscn").instantiate()
	_add_question_difficulty_menu(question_difficulty_menu)


func _add_question_difficulty_menu(question_difficulty_menu: Control):
	add_child(question_difficulty_menu)
	question_difficulty_menu.selected_difficulty.connect()
	
func _remove_question_difficulty_menu():
	for child in get_children():
		if child.name == "questionDifficulty":
			remove_child(child)

func _on_on_selected_difficulty(difficulty: int):
	_remove_question_difficulty_menu()
	#Aufruf QuestionMenu analog wie Aufruf DifficultyMenu
	#Methode von dem QuestioMenu aufrufen und difficulty übergeben
	pass

func _on_button_pressed():
	$Button.hide()
	map.move("/root/Node/Player", 3)

func _on_map_turn_ended():
	$Button.show()
