extends GridContainer

@onready var geld1 = $Geldstatus1
@onready var geld2 = $Geldstatus2
@onready var geld3 = $Geldstatus3
@onready var geld4 = $Geldstatus4

# Called when the node enters the scene tree for the first time.
func _ready():
	var spieler = $Spieler1 #change this based on playerturn
	spieler.add_theme_color_override("font_color", Color(1, 0.5, 0))
	
	var money = "100" #how to change the Text of Moneystats
	geld1.set_text(money + "Riesen")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
