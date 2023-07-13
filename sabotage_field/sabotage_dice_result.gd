extends Control

@onready var label=$CanvasLayer/Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var result="abc"
	label.set_text(result)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	self.visible = false

"""
var result;
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
"""
