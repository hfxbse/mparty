extends CanvasLayer

var dice_menu
var current_player: Player

signal received_dice_number(dnumber: int, player: Player)

func _ready():
	dice_menu = preload("res://dice/Dice.tscn").instantiate()
	dice_menu.dice_number.connect(_on_dice_number)

func on_player_begin_turn(player: Player):
	current_player = player
	add_child(dice_menu)
	
func _on_dice_number(dnumber: int):
	received_dice_number.emit(dnumber, current_player)
	
