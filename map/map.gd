extends Node

func get_start():
	return $Start

func move(playerPath: NodePath, distance: int):
	var player = get_node(playerPath)
	var path = player.current_location.path
	for n in distance:
		path.move(playerPath)
		await path.field_reached
