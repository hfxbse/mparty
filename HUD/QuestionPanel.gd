extends Panel

func _on_answer_a_pressed():
	var label = $Label
	var button = $Button
	label.set_text(String("Your response is A"))


func _on_answer_b_pressed():
	var label = $Label
	var button = $Button
	label.set_text(String("Your response is B"))


func _on_answer_c_pressed():
	var label = $Label
	var button = $Button
	label.set_text(String("Your response is C"))


func _on_answer_d_pressed():
	var label = $Label
	var button = $Button
	label.set_text(String("Your response is D"))