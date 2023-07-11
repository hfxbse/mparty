extends CanvasLayer

var dice_menu
var difficulty_menu
	
func add_dice_menu():
	dice_menu = preload("res://dice/Dice.tscn").instantiate()
	add_child(dice_menu)
	
	var dice_value = await dice_menu.dice_number
	await get_tree().create_timer(1.5).timeout
	
	remove_child(dice_menu)
	return dice_value
