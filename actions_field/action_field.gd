extends CanvasLayer

signal finished
var player: Player

func display(player):
	print("Displaying events")
	visible = true
	self.player = player
	return finished


func _on_button_pressed():
	visible = false
	var dice_menu = preload("res://dice/dice.tscn").instantiate()
	add_child(dice_menu)
	var dice_value = await dice_menu.dice_number
	remove_child(dice_menu)
	
	var result_display = preload("res://actions_field/action_results.tscn").instantiate()
	add_child(result_display)
	await result_display.display(player, dice_value)
	remove_child(result_display)
	finished.emit()
	
