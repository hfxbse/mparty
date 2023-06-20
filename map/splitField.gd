class_name SplitField extends Field

@onready var path2 = $Path2

signal path_picked
signal path2_picked
signal step_completed

var path_ended
var playerPath


func enable_path_option(path, picked_signal, receiver):
	picked_signal.connect(receiver)
	path.target.button.activate(picked_signal)


func disable_path_option(path, picked_signal, receiver):
	picked_signal.disconnect(receiver)
	path.target.button.deactivate()


func move(player: NodePath):
	playerPath = player
	
	enable_path_option(path, path_picked, _on_path_picked)
	enable_path_option(path2, path2_picked, _on_path2_picked)	
	
	return step_completed


func on_picked_handler(picked_path):
	disable_path_option(path, path_picked, _on_path_picked)
	disable_path_option(path2, path2_picked, _on_path2_picked)
	
	path_ended = picked_path.move(playerPath)
	path_ended.connect(_on_path_ended)
	

func _on_path_picked():
	on_picked_handler(path)


func _on_path2_picked():
	on_picked_handler(path2)


func _on_path_ended():
	path_ended.disconnect(_on_path_ended)
	step_completed.emit()
