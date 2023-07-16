extends Node

@onready var map = $Map
@onready var start : Field = map.start
@onready var current_player: Player

@onready var main_camera = $MainCamera
@onready var hud = $GameOverlay

var start_menu


func _ready():
	hud.camera_menu_pressed.connect(_on_menu_button_pressed)

	if DisplayServer.is_touchscreen_available():
		var mobile_hud = preload("res://overlay/mobile_hud.tscn").instantiate()
		mobile_hud.zoom_in.connect(main_camera.zoom_in)
		mobile_hud.zoom_out.connect(main_camera.zoom_out)

		hud.add_child(mobile_hud)
	
	start_menu = preload("res://start_menu/start_menu.tscn").instantiate()
	add_child(start_menu)
	start_menu.start_params.connect(_on_start_button_pressed)
	
	preload("res://data_providers/events/event_provider.gd")


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


func game_loop(num_rounds, num_players):
	State.init(create_players(num_players), start)
	
	hud.update_player_stats(current_player, State.players)

	for round in num_rounds:
		hud.update_round_count(round + 1, num_rounds)

		while true:
			print("Getting next player")
			var player = State.next_player
			if (player == null): 
				break
			await player_turn(player)

	State.players.sort_custom(func(player1, player2): 
			return player1.riesen + player1.patente < player2.riesen + player2.patente
	)

	var podium = preload("res://podium/podium.tscn").instantiate()
	add_child(podium)
	podium.display_winner(State.players)


func create_players(num):
	var player_scene = preload("res://player/player.tscn")
	var sprites = [
		preload("res://player/euro.svg"),
		preload("res://player/yen.svg"),
		preload("res://player/pound.svg"),
		preload("res://player/dollar.svg")
	]

	assert(num <= sprites.size(), "This game only supports 4 players")
	
	var players = []
	for i in num:
		var player : Player = player_scene.instantiate()

		add_child(player)
		players.append(player)

		player.current_location = start
		player.global_position = start.global_position
		player.riesen = 30
		player.patente = 0
		player.update.connect(_on_update)
		player.sprite.texture = sprites[i]
		player.sprite.visibility_layer = 9
		
		var regexPattern = "\\b(?!res\\b)\\w+\\b"
		var regex = RegEx.new()
		regex.compile(regexPattern)
		var matches = regex.search_all(sprites[i].resource_path)
		
		player.player_name = matches[1].get_string()
		
	return players


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
	
	hud.update_player_stats(current_player, State.players)

	await player.move(await roll_dice())

	current_player.z_index -= 1


func _on_update():
	hud.update_player_stats(current_player, State.players)


func _on_start_button_pressed(rounds_count: int, player_count: int):
	remove_child(start_menu)
	game_loop(rounds_count, player_count)
