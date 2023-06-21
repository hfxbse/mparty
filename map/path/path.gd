@tool
class_name MapPath extends Path2D

signal field_reached

var target
@export var target_field: NodePath:
	set(path):
		if path != target_field:
			target_field = path
			if Engine.is_editor_hint(): update_configuration_warnings()


@onready var follow = $Follow

const target_not_set = "Path target not set."
const target_type_mismatch = "Path target needs to be of type Field."


func _ready():
	if target_field.is_empty():
		target = null
	else:
		target = get_node(target_field)

	if not Engine.is_editor_hint():
		assert(target != null, target_not_set)
	else:
		update_configuration_warnings()


func _get_configuration_warnings():
	var errors = []

	if target_field.is_empty(): errors.append(target_not_set)

	return errors


func _process(delta):
	if Engine.is_editor_hint(): return

	if !follow.remote.update_position: return

	follow.progress_ratio +=  delta * 1.5

	if follow.progress_ratio >= 0.95:
		follow.progress_ratio = 1;
		field_reached.emit()

		follow.remote.update_position = false


func move(player: NodePath):
	follow.progress_ratio = 0
	follow.remote.remote_path = player
	follow.remote.update_position = true

	get_node(player).currentLocation = target

	return field_reached
