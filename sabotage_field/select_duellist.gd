extends CanvasLayer

signal terminate(target)
var player: Player


func display(player: Player):
	print("Choosing target")
	self.player = player
	visible = true
	return terminate


func _on_player_1_pressed():
	#Euro
	terminate.emit(State.players[0])


func _on_player_2_pressed():
	#Yen
	terminate.emit(State.players[1])
	

func _on_player_3_pressed():
	#Pound
	terminate.emit(State.players[2])


func _on_player_4_pressed():
	#Dollar
	terminate.emit(State.players[3])
