extends Node

@export var field_theme_override : FieldTheme

func event(player : Player):
	print("Patent_Office Triggered")
	var patent_office = preload("res://patent_office/patent_office.tscn").instantiate()
	add_child(patent_office)
	var is_done = await patent_office.start_transaction(player)
	remove_child(patent_office)
	
