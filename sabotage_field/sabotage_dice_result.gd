extends Control

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
	if (dice_value==7 || dice_value==8):
		result="Big Baller Duell Einsatz: halbes Vermögen"
	if (dice_value==9):
		result="Duell um Zug stehlen"
	if (dice_value==10):
		result="Erhalt Sabotage Freikarte"
	if (dice_value==11):
		result="Eigentor Verlust: 50 Riesen"
	if (dice_value==12):
		result="Duell Würfelgeld \nWert:gewürfelte Anzahl Riesen*10"
	
	label.set_text(result)
	
	return terminated


func duel_50():
	pass
	

func duel_big():
	pass
	
	
func steal_turn():
	pass
	
	
func sabotage_free_card():
	pass


func lose_50():
	pass
	
	
func duel_roll():
	pass
	
	
func get_target():
	var menu = preload("res://sabotage_field/select_duellist.tscn").instantiate()
	add_child(menu)
	var target = await menu.display(player)
	remove_child(menu)
	return target
	
