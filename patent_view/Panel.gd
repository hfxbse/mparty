extends Control

@onready var player1 = "Player1"
@onready var player2 = "Player2"
@onready var player3 = "Player3"
@onready var player4 = "Player4"

#get patent value
#connect with button in hud

func _ready():
	var player_patent = "40"
	$Panel/Player1.set_text(player1 + ": " + player_patent + " Riesen")
	$Panel/Player2.set_text(player2 + ": " + player_patent + " Riesen")
	$Panel/Player3.set_text(player3 + ": " + player_patent + " Riesen")
	$Panel/Player4.set_text(player4 + ": " + player_patent + " Riesen")


func _process(delta):
	pass


func _on_button_pressed():
	self.visible = false
