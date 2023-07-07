@tool

class_name AnswerButton extends Node

signal answer_selected(answer_text: String)


@onready var answer_button = $Button
@export var button_text: String = "":
	set(text):
		if text != button_text:
			button_text = text

			if answer_button:
				answer_button.text = text


func _ready():
	answer_button.text = button_text


func _on_button_pressed():
	answer_selected.emit(answer_button.text)
