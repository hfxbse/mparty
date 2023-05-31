extends Node

var player
var map
# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player
	map = $Map
	player.currentLocation = map.get_start()

func _on_button_pressed():
	map.move("/root/Node/Player", 2)
	
func _on_field_reached():
	print("Field reached")
	$Button.show();
