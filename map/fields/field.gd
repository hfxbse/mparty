class_name Field extends Button

@onready var path = $Path

signal picked


func move(player: Player):
	return path.move(player.get_path())


func enable_picker():
	disabled = false
	return picked


func disable_picker():
	disabled = true
	return picked


func _on_pressed():
	if !disabled: picked.emit()
