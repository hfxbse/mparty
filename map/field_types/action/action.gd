extends Node

@export var field_theme_override : FieldTheme

func event(player : Player):
	print("Event triggered")
	var action_panel = preload("res://actions_field/action_field.tscn").instantiate()
	add_child(action_panel)
	await action_panel.display(player)
	remove_child(action_panel)
