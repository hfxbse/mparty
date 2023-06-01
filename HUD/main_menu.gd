extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_start_pressed():
	$Panel/AnimationPlayer.play_backwards("popUpStart")
