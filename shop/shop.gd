extends Panel

@onready var label = $Label
@onready var animation = $AnimationPlayer

func _on_item_1_pressed():
	label.set_text(String("Your bought item 1, this costs ...€"))


func _on_item_2_pressed():
	label.set_text(String("Your bought item 2, this costs ...€"))


func _on_item_3_pressed():
	label.set_text(String("Your bought item 3, this costs ...€"))


func _on_item_4_pressed():
	label.set_text(String("Your bought item 4, this costs ...€"))


func _on_exit_button_pressed():
	animation.play_backwards("popUpUniversal")
