@tool
class_name FieldTheme extends Resource

@export var color_normal: Color:
	set(new_color):
		if new_color != color_normal:
			color_normal = new_color
			changed.emit()


@export var color_path_choice: Color:
	set(new_color):
		if new_color != color_path_choice:
			color_path_choice = new_color
			changed.emit()


@export var color_path_choice_picked: Color:
	set(new_color):
		if new_color != color_path_choice_picked:
			color_path_choice_picked = new_color
			changed.emit()


@export var color_path_choice_hover: Color:
	set(new_color):
		if new_color != color_path_choice_hover:
			color_path_choice_hover = new_color
			changed.emit()
