extends Node2D

func _on_item_1_pressed():
	var label = $Panel/Label
	var button = $Panel/Button
	label.set_text(String("Your bought item 1, this costs ...€"))


func _on_item_2_pressed():
	var label = $Panel/Label
	var button = $Panel/Button
	label.set_text(String("Your bought item 2, this costs ...€"))


func _on_item_3_pressed():
	var label = $Panel/Label
	var button = $Panel/Button
	label.set_text(String("Your bought item 3, this costs ...€"))


func _on_item_4_pressed():
	var label = $Panel/Label
	var button = $Panel/Button
	label.set_text(String("Your bought item 4, this costs ...€"))


func _on_exit_button_pressed():
	$Panel/AnimationPlayer.play_backwards("popUpShop")
