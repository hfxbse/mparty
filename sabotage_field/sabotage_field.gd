extends Control

var player

func _ready():
	self.visible = false


func _on_button_pressed():
	var dice_menu = preload("res://dice/dice.tscn").instantiate()
	add_child(dice_menu)
	var dice_value = await dice_menu.dice_number
	remove_child(dice_menu)
	
	var result_display = preload("res://sabotage_field/sabotage_dice_result.tscn").instantiate()
	add_child(result_display)
	await result_display.display(player, dice_value)
	remove_child(result_display)


func display(player: Player):
	self.player = player
	visible = true
	
