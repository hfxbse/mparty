class_name Path extends Path2D

signal field_reached
@export var targetPath : NodePath

@onready var target = get_node(targetPath)
@onready var follow = $Follow

func _process(delta):
	if !follow.remote.update_position:
		return

	follow.progress_ratio +=  delta * 1.5

	if follow.progress_ratio >= 0.95:
		follow.progress_ratio = 1;
		field_reached.emit()

		follow.remote.update_position = false


func move(player: NodePath):
	follow.progress_ratio = 0
	follow.remote.remote_path = player
	follow.remote.update_position = true

	get_node(player).currentLocation = target

	return field_reached

