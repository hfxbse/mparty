extends Panel

@onready var player1 = $GridContainer/Spieler1

# Called when the node enters the scene tree for the first time.
func _ready():
	set("GridContainer/Spieler1", Color(1,0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
