extends CanvasLayer

@onready var label = $Panel/Label
@onready var button = $Panel/Button

signal dice_number(dnumber: int)

func _on_button_pressed():
	var random = randi_range(1,12)
	
	label.set_text(String("%d" % random))
	button.hide()
	await get_tree().create_timer(1.5).timeout
	dice_number.emit(random)
	visible = false
