extends Node2D

@onready var path = $Path

func move(player: NodePath):
	return path.move(player)
