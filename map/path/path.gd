@tool
class_name MapPath extends Path2D

signal field_reached

const target_not_set = "Path target not set."
const curve_not_created = "Path curve not set."

@export var player_speed: float = 100

var target: Field
@export var target_field: NodePath:
	set(path):
		if path != target_field:
			target_field = path
			if Engine.is_editor_hint(): update_configuration_warnings()


func _set(property, value):
	match property:
		"curve":
			if curve != value:
				curve = value
				if Engine.is_editor_hint(): update_configuration_warnings()


@onready var follow = $Follow


func _ready():
	if target_field.is_empty():
		target = null
	else:
		target = get_node(target_field)

	if not Engine.is_editor_hint():
		assert(target != null, target_not_set)
		assert(curve != null, curve_not_created)
	else:
		update_configuration_warnings()


func _get_configuration_warnings():
	var errors = []

	if target_field.is_empty(): errors.append(target_not_set)
	if curve == null: errors.append(curve_not_created)

	return errors


func _process(delta):
	if Engine.is_editor_hint(): return

	if !follow.remote.update_position: return

	follow.progress_ratio +=  delta * 2.5 * player_speed / curve.get_baked_length()

	if follow.progress_ratio >= 0.95:
		follow.progress_ratio = 1;
		field_reached.emit(target)

		follow.remote.update_position = false


func move(player: NodePath):
	follow.progress_ratio = 0
	follow.remote.remote_path = player
	follow.remote.update_position = true

	return field_reached
