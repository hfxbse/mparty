extends Node

@onready var map = $Map
@onready var start : Field = map.start
@onready var current_player: Player

@onready var players = []

@onready var main_camera = $MainCamera
@onready var hud = $GameOverlay


func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")


func _ready():
	hud.camera_menu_pressed.connect(_on_menu_button_pressed)

	if DisplayServer.is_touchscreen_available():
		var mobile_hud = preload("res://overlay/mobile_hud.tscn").instantiate()
		mobile_hud.zoom_in.connect(main_camera.zoom_in)
		mobile_hud.zoom_out.connect(main_camera.zoom_out)

		hud.add_child(mobile_hud)
	
	start_game(10, 4)


func _process(delta):
	if Input.is_key_pressed(KEY_M):
		main_camera.set_camera()
	elif Input.is_key_pressed(KEY_P):
		current_player.camera.make_current()


func _on_menu_button_pressed(main_camera_selected: bool):
	main_camera.last_pos = current_player.position
	main_camera.zoom_out()

	if main_camera_selected:
		main_camera.set_camera()

	else:
		current_player.camera.make_current()


# Invoced by the start-screen to start the game
func start_game(num_rounds, num_players):
	create_players(num_players)
	hud.update_player_stats(current_player, players)

	for round in num_rounds:
		hud.update_round_count(round + 1, num_rounds)
		round_begin(round+1)

		for player in players:
			await player_turn(player)


func create_players(num):
	var player_scene = preload("res://player/player.tscn")
	var sprites = [
		preload("res://player/euro.svg"),
		preload("res://player/yen.svg"),
		preload("res://player/pound.svg"),
		preload("res://player/dollar.svg")
	]

	assert(num <= sprites.size(), "This game only supports 4 players")

	for i in num:
		var player : Player = player_scene.instantiate()

		add_child(player)
		players.append(player)

		player.current_location = start
		player.global_position = start.global_position
		player.change_patente.connect(on_player_change_patente)
		player.change_riesen.connect(on_player_change_riesen)
		player.sprite.texture = sprites[i]
		player.sprite.visibility_layer = 9


func roll_dice():
	var dice_menu = preload("res://dice/dice.tscn").instantiate()
	add_child(dice_menu)
	
	var dice_value = await dice_menu.dice_number
	remove_child(dice_menu)
	
	return dice_value


func player_turn(player):
	current_player = player
	current_player.z_index += 1
	current_player.camera.make_current()
	
	hud.update_player_stats(current_player, players)

	player_turn_begin(current_player)
	await player.move(await roll_dice())

	current_player.z_index -= 1


func on_player_change_riesen(player, amount):
	# Add code for communicating change to HUD
	pass


func on_player_change_patente(player, amount):
	# Add code for communicating change to HUD
	pass


func player_turn_begin(player):
	# Add code to display the current player in the HUD
	pass


func round_begin(round_num):
	# Add code to change the round display in the HUD
	pass
