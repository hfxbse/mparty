extends Button

var player: Player
signal clicked(player: Player)


func display(player):
	self.player = player
	icon = player.sprite.texture
	visible = true
	return clicked


func _on_pressed():
	clicked.emit(player)
