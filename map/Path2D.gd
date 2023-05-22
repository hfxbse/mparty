extends Path2D

signal field_reached()
@export var target : NodePath

var active
var follow

func _ready():
	var active = false
	var follow = $Follow
	follow.RemoteTrandform2d.update_position = false
	follow.RemoteTrandform2d.update_rotation = false

func _process(delta):
	if !active:
		return
	follow.progress_ratio +=  delta
	if follow.progress >= 1:
		field_reached.emit()
		active = false
		follow.RemoteTrandform2d.update_position = false
		follow.RemoteTrandform2d.update_rotation = false

func move(player: NodePath):
	follow.progress_ratio = 0
	follow.RemoteTrandform2d.remote_path = player
	follow.RemoteTrandform2d.update_position = true
	follow.RemoteTrandform2d.update_rotation = true
	get_node(player).current_location = target
	active = true
	
	
