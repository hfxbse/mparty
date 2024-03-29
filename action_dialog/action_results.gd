extends CanvasLayer

@onready var label=$CanvasLayer/Panel/Label

signal finished(action: Callable)

var player: Player
var action: Callable

var swap = {
	"text": "Spielertausch nach Wahl",
	"action": func(player, tree):
		var target = await get_target(tree)
		await player.swap_with(target)
}

var roll_again = {
	"text": "Nochmal würfeln",
	"action": func(player, tree):
		State.roll_again(player)
}

var go_back = {
	"text": "Alle bewegen sich zurück",
	"action": func(player, tree):
		var dice_menu = preload("res://dice/dice.tscn").instantiate()
		tree.add_child(dice_menu)
		var dice = await dice_menu.dice_number
		tree.remove_child(dice_menu)
		await State.all_move_back(dice)
}

var go_to_start = {
	"text": "Gehe zurück zum Start",
	"action": func(player, tree):
		await player.teleport(State.start)
}

var reduce_patents = {
	"text": "Alle Patente verlieren um 10% an Wert",
	"action": func(player, tree):
		State.all_change_patente(0.9)
}

var increase_patents = {
	"text": "Alle Patente gewinnen um 10% an Wert",
	"action": func(player, tree):
		State.all_change_patente(1.1)
}

var result_array = [swap, swap, roll_again, roll_again, go_back, go_back, go_to_start, go_to_start, roll_again, roll_again, reduce_patents, increase_patents]


func _on_button_pressed():
	visible = false
	finished.emit(action)


func display(player: Player, dice_value):
	self.player = player
	var result = result_array[dice_value-1]
	
	label.set_text(result["text"])
	action = result["action"]
	visible = true
	
	return finished


func get_target(tree):
	var menu = preload("res://select_target/select_target.tscn").instantiate()
	add_child(menu)
	var target = await menu.display(player)
	remove_child(menu)
	return target
