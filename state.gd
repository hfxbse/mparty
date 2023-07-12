extends Node

var players = []
var queue = []

var next_player : Player:
	get:
		if queue.is_empty():
			queue = players.duplicate()
			return null
		else:
			var player = queue.pop_front()
			if (player.skip):
				player.skip = false
				return next_player
			else:
				return player
			
			
func steal_turn(from, to):
	from.skip = true
	queue.push_front(to)
	
	
func roll_again(player):
	queue.push_front(player)
	

func swap_places(player1, player2):
	var tmp_field = player1.current_location
	var tmp_pos = player1.global_position
	player1.current_location = player2.current_location
	player1.global_position = player2.global_position
	player2.current_location = tmp_field
	player2.global_position = tmp_pos

