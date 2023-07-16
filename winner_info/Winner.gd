extends CanvasLayer

@onready var first=$Panel/First
@onready var second = $Panel/Second
@onready var third = $Panel/Third


func display_winner(players_in_order: Array[Player]):
	first.texture = players_in_order[0].sprite.texture
	first.texture = players_in_order[1].sprite.texture
	first.texture = players_in_order[2].sprite.texture
