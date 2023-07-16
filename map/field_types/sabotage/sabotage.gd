extends Node

@export var field_theme_override : FieldTheme

func event(player : Player):
	var sabotage_panel = preload("res://sabotage_dialog/sabotage_dialog.tscn").instantiate()
	add_child(sabotage_panel)
	await sabotage_panel.display(player)
	remove_child(sabotage_panel)
