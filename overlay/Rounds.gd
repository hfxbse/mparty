extends Panel

@onready var maxRound = $MaxRounds
@onready var roundStatus = $RoundStatus

# Called when the node enters the scene tree for the first time.
func _ready():	
	var round = "" #how to change the Text of Moneystats
	round = "15"
	maxRound.set_text(round)
	roundStatus.set_text("2")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
