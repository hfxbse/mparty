extends Panel

func _on_button_pressed():
	$Panel/AnimationPlayer.play("popUpScale")
	var label = $Panel/Label
	var button = $Panel/Button
	var random = randi_range(1,6)
	label.set_text(String("%d" % random))
	$Panel/AnimationPlayer.play("popUpUniversal")
	button.hide()
