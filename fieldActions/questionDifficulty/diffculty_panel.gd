extends Control

signal difficulty_selected(difficulty :int)

var difficulty
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_difficulty_1_pressed():
	difficulty = 0
	emit_signal("selected_difficulty", difficulty)


func _on_difficulty_2_pressed():
	difficulty = 1
	emit_signal("selected_difficulty", difficulty)


func _on_difficulty_3_pressed():
	difficulty = 2
	emit_signal("selected_difficulty", difficulty)

func _on_difficulty_selected(difficulty: int):
	var question_difficulty = preload("res://fieldActions/questionDifficulty/question_difficulty_scene.tscn")
	# Access the scene or pass the difficulty value as needed.
