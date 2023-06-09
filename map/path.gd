extends Path2D

signal field_reached
@export var targetPath : NodePath
@onready var target = get_node(targetPath)

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
	follow.progress_ratio +=  delta*1.5
	if follow.progress_ratio >= 0.95:
		follow.progress_ratio = 1;
		field_reached.emit()
		active = false
		follow.remote.update_position = false

func move(player: NodePath):
	follow.progress_ratio = 0
	follow.remote.remote_path = player
	follow.remote.update_position = true
	get_node(player).currentLocation = target
	active = true
	return field_reached
	
	
