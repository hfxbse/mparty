extends Node

## HUD Elements can attach here to show current Player
signal player_turn_begin(player)
## HUD Elements can attach here to update Player "Riesen" Display
signal player_change_riesen(player, amount)
## HUD Elements can attach here to update Player "Patente" Display
signal player_change_patente(player, amount)
## HUD Elements can attach here to show current Round
signal round_begin(roundNum)

@onready var map = $Map
@onready var start : Field = map.start
@onready var current_player: Player

@onready var players = []

@onready var main_camera = $MainCamera
@onready var player_camera = $Player/PlayerCamera
@onready var hud = $HUD


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
		player_camera.make_current()


func _on_menu_button_pressed(main_camera_selected: bool):
	main_camera.last_pos = current_player.position
	main_camera.zoom_out()

	if main_camera_selected:
		main_camera.set_camera()

	else:
		player_camera.make_current()
		
		
func start_game(num_rounds, num_players):
## Is called by the start-screen to start the game
	create_players(num_players)
	for round in num_rounds:
		round_begin.emit(round+1)
		for player in players:
			await player_turn(player)


func create_players(num):
	var player_scene = load("res://player/player.tscn")
	var sprites = ["res://player/euro.svg", "res://player/yen.svg", "res://player/pound.svg", "res://player/dollar.svg"]
	for i in num:
		var player : Player = player_scene.instantiate()
		add_child(player)
		player.current_location = start
		player.global_position = start.global_position
		player.change_patente.connect(on_player_change_patente)
		player.change_riesen.connect(on_player_change_riesen)
		player.sprite.texture = load(sprites[i])
		player.sprite.visibility_layer = 9
		players.append(player)


func roll_dice():
## roll dice and return the eyecount
	pass


func player_turn(player):
	current_player = player
	current_player.z_index += 1
	player_turn_begin.emit(current_player)
	## var diceRoll = await roll_dice()
	var diceRoll = 3
	await player.move(diceRoll)
	current_player.z_index -= 1


func on_player_change_riesen(player, amount):
	player_change_riesen.emit(player, amount)


func on_player_change_patente(player, amount):
	player_change_patente.emit(player, amount)
