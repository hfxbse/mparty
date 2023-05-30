extends Node2D

func _on_button_start_pressed():
	$Panel/AnimationPlayer.play_backwards("popUpStart")
