extends CanvasLayer

@onready var menu_button = $MenuButton

var main_camera_selected: bool = false

signal camera_menu_pressed(main_camera_selected: bool)

func _ready():
	camera_menu_pressed.connect(_on_menu_button_pressed)

func _on_menu_button_pressed():
	main_camera_selected = !main_camera_selected
	camera_menu_pressed.emit(main_camera_selected)
