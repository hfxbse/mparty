@tool
class_name Field extends Button

signal picked
signal step_completed(reached_field)
const missing_path_warning = "Field needs at least one MapPath."

var paths: Array[MapPath]
var picked_receivers: Array[Callable]
var field_reached: Signal


func _ready():
	paths = []

	for child in get_children():
		if child is MapPath:
			paths.append(child)

	if not Engine.is_editor_hint():
		assert(not paths.is_empty(), missing_path_warning)
	else:
		update_configuration_warnings()


func _get_configuration_warnings():
	var errors = []

	if paths.is_empty(): errors.append(missing_path_warning)

	return errors


func move_backwards(player: Player):
	for path in paths:
		if path.target == player.current_location:
			player.current_location = self
			return path.move_backwards(player.get_path())

	assert(false, "Field is not connected to current location of the player.")


func move_forwards(player: Player):
	if paths.size() == 1:
		return paths[0].move_forwards(player.get_path())


	picked_receivers.clear()

	for path in paths:
		picked_receivers.append(func (): move_along_picked_path(player, path))
		path.target.enable_picker().connect(picked_receivers.back())

	return step_completed


func move_along_picked_path(player, path):
	disable_pickers()

	field_reached = path.move_forwards(player.get_path())
	field_reached.connect(_on_field_reached)


func disable_pickers():
	for path in paths:
		path.target.disable_picker().disconnect(picked_receivers.pop_front())


func enable_picker() -> Signal:
	disabled = false
	return picked


func disable_picker() -> Signal:
	disabled = true
	return picked


func _on_pressed():
	if !disabled: picked.emit()

func _on_field_reached(reached_field):
	field_reached.disconnect(_on_field_reached)
	step_completed.emit(reached_field)
