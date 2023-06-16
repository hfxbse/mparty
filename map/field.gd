extends Node2D

@onready var path = $Path
@onready var button = $TextureButton

func move(player: NodePath):
	return path.move(player)
