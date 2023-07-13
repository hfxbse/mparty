extends Control

@onready var label = $CanvasLayer/Panel/Label
@onready var button = $CanvasLayer/Panel/Button

signal dice_number(dnumber: int)

func _on_button_pressed():
	var random = randi_range(1,12)
	
	label.set_text(String("%d" % random))
	dice_number.emit(random)
	
	button.hide()
