extends QuestionPanel

func _on_button_left_pressed():
	var label = $Label
	var button = $ButtonLeft
	label.set_text(String("Your decided to turn left"))


func _on_button_forward_pressed():
	var label = $Label
	var button = $ButtonForward
	label.set_text(String("Your decided to turn forward"))


func _on_button_right_pressed():
	var label = $Label
	var button = $ButtonRight
	label.set_text(String("Your decided to turn right"))
