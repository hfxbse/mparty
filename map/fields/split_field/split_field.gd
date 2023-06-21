class_name SplitField extends Node2D

var field
@onready var path2 = $Path2


signal step_completed

var path_ended
var playerPath

const missing_field_warning = "SplitField needs a Field as child node."
const too_many_fields_warining = "SplitField cannot have more than one Field as child."


func get_fields():
	var fields = []
	
	for child in get_children():
		if child is Field:
			fields.append(child)

	return fields


func _ready():
	var fields = get_fields()
	assert(!fields.is_empty(), missing_field_warning)
	assert(fields.size() == 1, too_many_fields_warining)

	field = fields[0]


func enable_picker():
	return field.enable_picker()


func disable_picker():
	return field.disable_picker()


func enable_path_option(path, receiver):
	path.target.enable_picker().connect(receiver)


func disable_path_option(path, receiver):
	path.target.disable_picker().disconnect(receiver)


func move(player: Player):
	playerPath = player.get_path()
	
	enable_path_option(field.path, _on_path_picked)
	enable_path_option(path2, _on_path2_picked)
	
	return step_completed


func on_picked_handler(picked_path):
	disable_path_option(field.path, _on_path_picked)
	disable_path_option(path2, _on_path2_picked)
	
	path_ended = picked_path.move(playerPath)
	path_ended.connect(_on_path_ended)
	

func _on_path_picked():
	on_picked_handler(field.path)


func _on_path2_picked():
	on_picked_handler(path2)


func _on_path_ended():
	path_ended.disconnect(_on_path_ended)
	step_completed.emit()
