extends CanvasLayer

@onready var label=$CanvasLayer/Panel/Label

signal terminated

var player: Player
var action: Callable


func _on_button_pressed():
	visible = false
	await action.call()
	terminated.emit()


func display(player: Player, dice_value):
	self.player = player
	var result = ""

	if dice_value <= 2:
		result = "Spielertausch nach Wahl"
		action = swap
	elif dice_value <= 4:
		result = "Nochmal würfeln"
		action = roll_again
	elif dice_value <= 6:
		result = "Alle bewegen sich zurück"
		action = go_back
	elif dice_value <= 8:
		result = "Gehe zurück zum Start"
		action = go_to_start
	elif dice_value <= 10:
		result = "Nochmal würfeln"
		action = roll_again
	elif dice_value == 11:
		result = "Alle Patente verlieren um 10% an Wert"
		action = reduce_patents
	elif dice_value == 12:
		result = "Alle Patente gewinnen um 10% an Wert"
		action = increase_patents
	
	label.set_text(result)
	visible = true
	
	return terminated


func swap():
	var target = await get_target()
	player.swap_with(target)
	
	
func roll_again():
	State.roll_again(player)


func go_back():
	var dice_menu = preload("res://dice/dice.tscn").instantiate()
	add_child(dice_menu)
	var dice_value = await dice_menu.dice_number
	remove_child(dice_menu)
	
	State.all_move_back(dice_value)


func go_to_start():
	player.teleport(State.start)


func reduce_patents():
	State.all_change_patente(0.9)


func increase_patents():
	State.all_change_patente(1.1)


func get_target():
	var menu = preload("res://select_target/select_target.tscn").instantiate()
	add_child(menu)
	var target = await menu.display(player)
	remove_child(menu)
	return target
