extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@onready var duellist = "" #enums would be better
#send player back to duell method

func _on_player_1_pressed():
	duellist="Player1"

func _on_player_2_pressed():
	duellist="Player2"

func _on_player_3_pressed():
	duellist="Player3"

func _on_player_4_pressed():
	duellist="Player4"
