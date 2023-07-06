extends GridContainer

@onready var money1 = $Money1
@onready var money2 = $Money2
@onready var money3 = $Money3
@onready var money4 = $Money4

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = $Player1 #change this based on playerturn
	player.add_theme_color_override("font_color", Color(1, 0.5, 0))
	
	var money = "100" #how to change the Text of Moneystats
	money1.set_text(money + " Riesen")
	money="200"
	money2.set_text(money + " Riesen")
	money="200"
	money3.set_text(money + " Riesen")
	money="400"
	money4.set_text(money + " Riesen")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
