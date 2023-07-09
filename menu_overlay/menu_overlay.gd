extends CanvasLayer

var dice_menu
var difficulty_menu
var current_player: Player

signal received_dice_number(dnumber: int, player: Player)

func _ready():
	dice_menu = preload("res://dice/Dice.tscn").instantiate()
	dice_menu.dice_number.connect(_on_dice_number)
	ask_difficulty()

func on_player_begin_turn(player: Player):
	current_player = player
	add_child(dice_menu)
	
func _on_dice_number(dnumber: int):
	received_dice_number.emit(dnumber, current_player)
	
func ask_difficulty():
	#add_child(difficulty_menu)
	pass
	
func _on_difficulty(diff: Question.Difficulty):
	pass
	
func add_dice_menu():
	dice_menu = preload("res://dice/Dice.tscn").instantiate()
	dice_menu.dice_number.connect(_on_dice_number)
	add_child(dice_menu)
	
	var dice_value = await dice_menu.dice_number
	print(dice_value)
	await get_tree().create_timer(1.5).timeout
	remove_child(dice_menu)
	return dice_value

