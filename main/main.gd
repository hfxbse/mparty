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
@onready var currentPlayer: Player = $Player

@onready var players = []

func _init():
	var question_handler = preload("res://data_providers/resources/question_provider.tres")
	#Example call
	print(question_handler.get_next_question(Question.Difficulty.EASY).question)
	print(question_handler.get_random_question(Question.Difficulty.EASY).question)

func _ready():
	startGame(10, 3)


func startGame(numRounds, numPlayers):
## Is called by the start-screen to start the game
	createPlayers(numPlayers)
	orderPlayers(numPlayers)
	for round in numRounds:
		round_begin.emit(round+1)
		for player in players:
			await playerTurn(player)


func createPlayers(num):
	var playerScene = load("res://player/player.tscn")
	var sprites = ["res://player/euro.svg", "res://player/yen.svg", "res://player/pound.svg"]
	for i in num:
		var player : Player = playerScene.instantiate()
		add_child(player)
		player.current_location = start
		player.global_position = start.global_position
		player.change_patente.connect(on_player_change_patente)
		player.change_riesen.connect(on_player_change_riesen)
		player.sprite.texture = load(sprites[i])
		players.append(player)


func orderPlayers(numPlayers):
## Optional
## Get order of players by rolling dice
## Order Players Accordingly
	pass


func rollDice():
## roll dice and return the eyecount
	pass


func playerTurn(player):
	currentPlayer = player
	player_turn_begin.emit(currentPlayer)
	## var diceRoll = await rollDice()
	var diceRoll = 3
	await player.move(diceRoll)


func on_player_change_riesen(player, amount):
	player_change_riesen.emit(player, amount)


func on_player_change_patente(player, amount):
	player_change_patente.emit(player, amount)
