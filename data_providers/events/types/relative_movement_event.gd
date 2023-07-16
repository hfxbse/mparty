class_name RelativeMovementEvent extends Event

var distance: int

enum Direction { 
	FORWARD, 
	BACKWARD
}


func _init(text: String, distance: int, direction: Direction):
	self.text = text % distance if text.contains("%d") else text

	distance = abs(distance)
	self.distance = -1 * distance if distance == Direction.BACKWARD else distance
