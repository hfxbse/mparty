extends CanvasLayer

@onready var label=$CanvasLayer/Panel/Label

signal terminated

var player: Player
var action: Callable

func _ready():
	visible = false


func _on_button_pressed():
	await action.call()
	terminated.emit()


func display(player: Player, dice_value):
	self.player = player
	visible = true
	var result = ""

	#get label and action from dice value
	
	label.set_text(result)
	
	return terminated


"""
func get_target():
	var menu = preload("res://sabotage_field/select_duellist.tscn").instantiate()
	add_child(menu)
	var target = await menu.display(player)
	remove_child(menu)
	return target
"""
