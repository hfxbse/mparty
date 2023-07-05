extends Panel

@onready var maxRound = $MaxRounds
@onready var roundStatus = $RoundStatus

# Called when the node enters the scene tree for the first time.
func _ready():
	var spieler = $Spieler1 #change this based on playerturn
	spieler.add_theme_color_override("font_color", Color(1, 0.5, 0))
	
	var round = "" #how to change the Text of Moneystats
	round = "100"
	maxRound.set_text(round)
	roundStatus.set_text("15")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
