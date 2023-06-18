class_name AnswerButton extends Button

signal answer_selected(answer_text: String)

func _init(button_text):
	self.text = button_text
	self.custom_minimum_size = Vector2(100, 150)
	self.add_theme_font_size_override("font_size", 30)
	self.pressed.connect(_on_answer_button_pressed)
	
	var pressed_style_box = StyleBoxFlat.new()
	pressed_style_box.bg_color = Color(0.015, 0.988, 0.517)
	self.add_theme_stylebox_override("focus", pressed_style_box)
	
func _on_answer_button_pressed():
	self.add_theme_color_override("color", Color(100.0, 100.0, 100.0))
	answer_selected.emit(self.text)
