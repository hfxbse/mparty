extends Path2D

signal field_reached()
@export var target : NodePath

var active
var follow

func _ready():
	active = false
	follow = $Follow
	follow.remote.update_position = false
	follow.remote.update_rotation = false

func _process(delta):
	if !active:
		return
	follow.progress_ratio +=  delta
	if follow.progress_ratio >= 0.95:
		follow.progress_ratio = 1;
		field_reached.emit()
		active = false
		follow.remote.update_position = false
		follow.remote.update_rotation = false

func move(player: NodePath):
	follow.progress_ratio = 0
	follow.remote.remote_path = player
	follow.remote.update_position = true
	follow.remote.update_rotation = true
	get_node(player).current_location = target
	active = true
	return field_reached
	
	
