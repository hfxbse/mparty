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


func init(players, start):
	self.players = players.duplicate()
	self.queue = players.duplicate()
	self.start = start


func steal_turn(to, from):
	from.skip = true
	queue.push_front(to)
	
	
func roll_again(player):
	queue.push_front(player)
	
	
func all_move_back(amount):
	for player in players:
		await  player.move_backwards(amount)
		
		
func all_reduce_riesen(rate):
	for player in players:
		player.riesen = floor(player.riesen * (1 - rate))
	
	
func all_change_patente(rate):
	for player in players:
		player.patente = floor(player.patente * rate)



