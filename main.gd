extends Node

var player
var map
# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player
	map = $Map
	player.current_location = map.get_start()

func _on_button_pressed():
	$Button.hide();
	get_node(map.get_start()).path.move("/root/Node/Player").connect(_on_field_reached);
	
func _on_field_reached():
	print("Field reached")
	$Button.show();
