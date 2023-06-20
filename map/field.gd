class_name Field extends Node2D

@onready var path = $Path
@onready var button = $TextureButton

func move(player: Player):
	return path.move(player.get_path())
