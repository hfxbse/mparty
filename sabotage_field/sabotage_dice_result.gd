extends Control

@onready var label=$CanvasLayer/Panel/Label

signal terminated

var player: Player

func _ready():
	visible = false


func _on_button_pressed():
# execute sabotage
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
