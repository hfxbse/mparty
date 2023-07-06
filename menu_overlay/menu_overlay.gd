extends CanvasLayer

var dice_menu
var difficulty_menu
var current_player: Player

signal received_dice_number(dnumber: int, player: Player)

func _ready():
	dice_menu = preload("res://dice/Dice.tscn").instantiate()
	difficulty_menu = preload("res://feld_aktionen/question_difficulty/question_difficulty.tscn").instantiate()
	dice_menu.dice_number.connect(_on_dice_number)
	difficulty_menu.difficulty.connect(_on_difficulty)
	ask_difficulty()

func on_player_begin_turn(player: Player):
	current_player = player
	add_child(dice_menu)
	
func _on_dice_number(dnumber: int):
	received_dice_number.emit(dnumber, current_player)
	
func ask_difficulty():
	add_child(difficulty_menu)

func _on_difficulty(diff: Question.Difficulty):
