@tool
class_name Field extends Button

signal picked
signal step_completed(reached_field)
const missing_path_warning = "Field needs at least one MapPath."

var paths: Array[MapPath]
var picked_receivers: Array[Callable]
var field_reached: Signal


var shadow_color_overrides: Dictionary = {
	"disabled": func (): return theme_override.field_color,
	"normal": func (): return theme_override.shadow_color_normal,
	"hover": func (): return theme_override.shadow_color_normal,
	"pressed": func (): return theme_override.shadow_color_pressed,
}


@export var theme_override: FieldTheme:
	set(theme):
		if theme != theme_override:
			if theme_override != null:
				theme_override.changed.disconnect(apply_theme_overide)
			if theme != null: 
				theme.changed.connect(apply_theme_overide)

			theme_override = theme
			apply_theme_overide()


func apply_theme_overide():
	for style_name in theme.get_stylebox_list("Button"):
		if theme_override == null:
			remove_theme_stylebox_override(style_name)
			continue

		var style: StyleBoxFlat = theme.get_stylebox(style_name, "Button").duplicate()
		style.bg_color = theme_override.field_color

		var shadow_color = shadow_color_overrides.get(style_name)
		if shadow_color != null: style.shadow_color = shadow_color.call()

		add_theme_stylebox_override(style_name, style)


func _ready():
	paths = []
	var child_theme_override: FieldTheme = null

	for child in get_children():
		if child is MapPath:
			paths.append(child)
		
		if "field_theme_override" in child && child.field_theme_override != null:
			child_theme_override = child.field_theme_override

	if theme_override == null:
		theme_override = child_theme_override

	if not Engine.is_editor_hint():
		assert(not paths.is_empty(), missing_path_warning)
	else:
		update_configuration_warnings()


func _get_configuration_warnings():
	var errors = []

	if paths.is_empty(): errors.append(missing_path_warning)

	return errors


func move_backwards(player: Player):
	if player.traversed_fields.is_empty(): return

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
