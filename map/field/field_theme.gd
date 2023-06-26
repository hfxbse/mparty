@tool
class_name FieldTheme extends Resource


@export var field_color: Color:
	set(color):
		if color != field_color:
			field_color = color
			changed.emit()


@export var shadow_color_normal: Color:
	set(color):
		if color != shadow_color_normal:
			shadow_color_normal = color
			changed.emit()


@export var shadow_color_pressed: Color:
	set(color):
		if color != shadow_color_pressed:
			shadow_color_pressed = color
			changed.emit()
