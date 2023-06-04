<<<<<<<< HEAD:HUD/WayDecision.gd
extends Node2D
========
extends QuestionPanel
>>>>>>>> 75c0598 (Layout Changes):HUD/Panel.gd

func _on_button_left_pressed():
	var label = $Panel/Label
	var button = $Panel/Button
	label.set_text(String("Your decided to turn left"))


func _on_button_forward_pressed():
	var label = $Panel/Label
	var button = $Panel/Button
	label.set_text(String("Your decided to turn forward"))


func _on_button_right_pressed():
	var label = $Panel/Label
	var button = $Panel/Button
	label.set_text(String("Your decided to turn right"))
