extends Panel

func _on_exit_button_pressed():
	$AnimationPlayer.play_backwards("popUpUniversal")
