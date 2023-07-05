extends CanvasLayer

signal zoom_in()
signal zoom_out()

func _on_zoom_in_button_pressed():
	zoom_in.emit()


func _on_zoom_out_button_pressed():
	zoom_out.emit()
