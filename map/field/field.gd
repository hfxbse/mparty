@tool
class_name Field extends Button

signal picked
signal step_completed(reached_field)
const missing_path_warning = "Field needs at least one MapPath."

var paths: Array[MapPath]
var picked_receivers: Array[Callable]
var field_reached: Signal
var field_events: Array[Callable]
var driveby_events: Array[Callable]


@export var rounded: bool = false:
	set(round):
		if rounded != round:
			rounded = round
			apply_theme_overide()


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
		if theme_override == null && !rounded:
			remove_theme_stylebox_override(style_name)
			continue

		var style: StyleBoxFlat = theme.get_stylebox(style_name, "Button").duplicate()

		if theme_override != null:
			style.bg_color = theme_override.field_color

			var shadow_color = shadow_color_overrides.get(style_name)
			if shadow_color != null: style.shadow_color = shadow_color.call()

		if rounded:
			style.corner_radius_bottom_left = 40
			style.corner_radius_bottom_right = 40
			style.corner_radius_top_left = 40
			style.corner_radius_top_right = 40

		add_theme_stylebox_override(style_name, style)


func _ready():
	paths = []
	var child_theme_override: FieldTheme = null

	for child in get_children():
		if child is MapPath:
			paths.append(child)
			
		if child.is_in_group("event"):
			if child.name == "patent_office":
				driveby_events.append(child.event)
			else:
				field_events.append(child.event)

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


func available_paths(player: Player):
	return paths.filter(func(path): 
		return path.target != player.last_transversed
	)


func move_backwards(player: Player):
	for path in paths:
		if path.target == player.current_location:
			player.current_location = self
			return path.move_backwards(player.get_path())

	assert(false, "Field is not connected to current location of the player.")


func move_forwards(player: Player):
	var forward_paths = available_paths(player)

	assert(!forward_paths.is_empty(), "No path to a new field connected.")

	if forward_paths.size() == 1:
		return forward_paths[0].move_forwards(player.get_path())

	picked_receivers.clear()

	for path in forward_paths:
		picked_receivers.append(func (): move_along_picked_path(player, path))
		path.target.enable_picker().connect(picked_receivers.back())

	return step_completed


func move_along_picked_path(player: Player, path):
	disable_pickers(player)

	field_reached = path.move_forwards(player.get_path())
	field_reached.connect(_on_field_reached)


func disable_pickers(player: Player):
	var forward_paths =  available_paths(player)

	for path in forward_paths:
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
