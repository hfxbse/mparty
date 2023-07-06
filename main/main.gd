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
@onready var current_player: Player = $Player

@onready var players = []

func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)
	print(question_handler.get_random_question(Question.Difficulty.EASY).question)

func _ready():
	start_game(10, 3)


func start_game(num_rounds, num_players):
## Is called by the start-screen to start the game
	create_players(num_players)
	for round in num_rounds:
		round_begin.emit(round+1)
		for player in players:
			await player_turn(player)


func create_players(num):
	var player_scene = load("res://player/player.tscn")
	var sprites = ["res://player/euro.svg", "res://player/yen.svg", "res://player/pound.svg"]
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
