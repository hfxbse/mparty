extends CanvasLayer

@onready var label=$CanvasLayer/Panel/Label

signal terminated

var player: Player
var action: Callable

func _ready():
	visible = false


func _on_button_pressed():
	await action.call()
	terminated.emit()

func display(player: Player, dice_value):
	self.player = player
	visible = true

	var result
	if (dice_value<=6):
		result="Duell Einsatz: 50 Riesen"
		action = duel_50
	if (dice_value==7 || dice_value==8):
		result="Big Baller Duell Einsatz: halbes Vermögen"
		action = duel_big
	if (dice_value==9):
		result="Duell um Zug stehlen"
		action = steal_turn
	if (dice_value==10):
		result="Erhalt Sabotage Freikarte"
		action = sabotage_free_card
	if (dice_value==11):
		result="Eigentor Verlust: 50 Riesen"
		action = lose_50
	if (dice_value==12):
		result="Duell Würfelgeld \nWert:gewürfelte Anzahl Riesen*10"
		action = duel_roll
	
	label.set_text(result)
	
	return terminated


func duel_50():
	var target = await get_target()


func duel_big():
	var target = await get_target()
	
	
func steal_turn():
	var target = await get_target()
	State.steal_turn(player, target)
	
	
func duel_roll():
	var target = await get_target()
	
	
func sabotage_free_card():
	player.sabotage_card = true


func lose_50():
	player.riesen -= 50
	
	
func get_target():
	var menu = preload("res://sabotage_field/select_duellist.tscn").instantiate()
	add_child(menu)
	var target = await menu.display(player)
	remove_child(menu)
	return target
	
