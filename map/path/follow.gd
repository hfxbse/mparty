class_name Remote extends PathFollow2D

@onready var remote = $RemoteTransform2D
var speed
var end:
	set(value):
		if end != value:
			end = clamp(value, 0, 1)


func move(delta):
	progress_ratio = clamp(delta * speed + progress_ratio, 0, 1)

	if end_reached():
		remote.update_position = false


func end_reached():
	return progress_ratio == end
