extends Node

@onready var player: Player = $Player
@onready var map = $Map
@onready var MoveButton = $MoveButton
@onready var main_camera = $MainCamera
@onready var player_camera = $Player/PlayerCamera
@onready var hud = $HUD

signal turn_start()

func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")


func _ready():
	var start = map.start
	player.current_location = start
	player.global_position = start.global_position

	player.turn_ended.connect(_on_player_turn_ended)
	hud.camera_menu_pressed.connect(_on_menu_button_pressed)

	if DisplayServer.is_touchscreen_available():
		var mobile_hud = preload("res://overlay/mobile_hud.tscn").instantiate()
		mobile_hud.zoom_in.connect(main_camera.zoom_in)
		mobile_hud.zoom_out.connect(main_camera.zoom_out)
		hud.add_child(mobile_hud)


func _on_menu_button_pressed(main_camera_selected: bool):
	main_camera.last_pos = player.position
	main_camera.zoom_out()

	if main_camera_selected:
		main_camera.set_camera()

	else:
		player_camera.make_current()


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
	if Input.is_key_pressed(KEY_M):
		main_camera.set_camera()
	elif Input.is_key_pressed(KEY_P):
		player_camera.make_current()

