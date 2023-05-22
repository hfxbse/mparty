class_name EventBattle extends Event

var player1: Player
var player2: Player

func set_player(player1_input: Player, player2_input: Player):
	player1 = player1_input
	player2 = player2_input

func get_player():
	return player1
	return player2

#TODO Add battle action
func action():
	pass
