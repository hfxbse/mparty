extends GridContainer

@onready	var player1 = "Player1"
@onready	var player2 = "Player2"
@onready	var player3 = "Player3"
@onready	var player4 = "Player4"

func _ready():
	
	$Player1.set_text(player1)
	$Player2.set_text(player2)
	$Player3.set_text(player3)
	$Player4.set_text(player4)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
