extends Panel

func _on_button_pressed():
	$AnimationPlayer.play("popUpScale")
	var label = $Label
	var button = $Button
	var random = randi_range(1,6)
	label.set_text(String("%d" % random))
	$AnimationPlayer.play("popUpUniversal")
	button.hide()
