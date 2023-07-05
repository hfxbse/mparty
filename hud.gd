extends CanvasLayer

@onready var menu_button = $MarginContainer/MenuButton

signal hud_id_pressed(id: int, item_count: int)

func _ready():
	menu_button.get_popup().id_pressed.connect(_on_id_pressed)
	
func _on_id_pressed(id: int):
	hud_id_pressed.emit(id, menu_button.item_count)
