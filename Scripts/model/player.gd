class_name Player

var position
var points

func dice_roll():
	return randi() % 10
	
func move(steps: int):
	pass
	
func set_points(points_input: int):
	points = points_input
