extends Control

@onready var animation = $AnimationPlayer
@onready var label = $Label
@onready var button = $Button

func _on_button_pressed():
	var random = randi_range(1,12)
	
	label.set_text(String("%d" % random))
	button.hide()
	await get_tree().create_timer(1.5).timeout
	self.visible = false
