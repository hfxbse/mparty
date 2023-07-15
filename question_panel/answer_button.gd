@tool

class_name AnswerButton extends Node

signal button_pressed(answer_text: String)


@onready var answer_button_label = $Button/Label

@export var button_text: String = "":
	set(text):
		if text != button_text:
			button_text = text

			if answer_button_label:
				answer_button_label.text = text


func _ready():
	answer_button_label.text = button_text


func _on_button_pressed():
	button_pressed.emit(answer_button_label.text)
	
func _wrong_answer_selected():
	answer_button_label.add_theme_color_override("font_color", Color(255,0,0))

	
func _right_answer_selected():
	answer_button_label.add_theme_color_override("font_color", Color(0,128,0))
	
