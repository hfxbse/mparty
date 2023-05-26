extends Node2DWayDecision

func _on_button_pressed():
		$Panel/AnimationPlayer.play("popWayDecision")
	var label = $Panel2/Label
	var button = $Panel2/Button
	var random = randi_range(1,6)
	label.set_text(String("%d" % random))
	$Panel2/AnimationPlayer.play_backwards("popWayDecison")
	button.hide()
