extends Control

@onready var difficulty = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_difficulty_1_pressed():
	difficulty=0

func _on_difficulty_2_pressed():
	difficulty=1

func _on_difficulty_3_pressed():
	difficulty=3
