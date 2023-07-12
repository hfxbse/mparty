extends Node

var players = []
var queue = []
var start

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
	
	
func move_to_start(player):
	player.teleport(start)
	
	
func all_move_back(amount):
	for player in players:
		await  player.move_backwards(amount)
		
		
func all_reduce_riesen(rate):
	for player in players:
		player.riesen = floor(player.riesen * (1 - rate))
	
	
func all_reduce_patente(rate):
	for player in players:
		player.patente = floor(player.patente * (1 - rate))



