extends CanvasLayer

@onready var first = $Panel/First
@onready var second = $Panel/Second
@onready var third = $Panel/Third


func display_winner(players_in_order: Array):
	assert(players_in_order.size() >= 2, "Too few players to display winners.")
	
	first.texture = players_in_order[0].sprite.texture
	second.texture = players_in_order[1].sprite.texture
	
	if players_in_order.size() > 2:
		third.texture = players_in_order[2].sprite.texture
