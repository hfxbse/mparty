extends Node

@onready var player: Player = $Player
@onready var map = $Map
@onready var MoveButton = $MoveButton
@onready var main_camera = $MainCamera
@onready var player_camera = $Player/PlayerCamera

var hud

signal turn_start()

func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)
	print(question_handler.get_random_question(Question.Difficulty.EASY).question)
	
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		hud = preload("res://mobile_hud.tscn").instantiate()
		add_child(hud)


func _ready():
	var start = map.start
	player.current_location = start
	player.global_position = start.global_position


func _on_button_pressed():
	MoveButton.hide()
	player.move(2)


func _on_player_turn_ended():
	MoveButton.show()


func _on_back_button_pressed():
	player.move_backwards(1)


func _on_undo_button_pressed():
	player.undo_last_move()
	
func _process(delta):
	if(Input.is_key_pressed(KEY_M)):
		main_camera.set_camera()
	elif(Input.is_key_pressed(KEY_P)):
		player_camera.make_current()
