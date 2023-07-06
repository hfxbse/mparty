extends Panel

@onready var player1 = "Player1"
@onready var player2 = "Player2"
@onready var player3 = "Player3"
@onready var player4 = "Player4"

#get patent value
#connect with button in hud

func _ready():
	var player_patent = "40"
	$Player1.set_text(player1 + ": " + player_patent + " Riesen")
	$Player2.set_text(player2 + ": " + player_patent + " Riesen")
	$Player3.set_text(player3 + ": " + player_patent + " Riesen")
	$Player4.set_text(player4 + ": " + player_patent + " Riesen")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	self.visible = false
