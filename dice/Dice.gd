extends Panel

@onready var animation = $AnimationPlayer
@onready var label = $Label
@onready var button = $Button

func _on_button_pressed():
	var random = randi_range(1,6)
	
	animation.play("popUpScale")
	label.set_text(String("%d" % random))
	animation.play("popUpScale")
	button.hide()
