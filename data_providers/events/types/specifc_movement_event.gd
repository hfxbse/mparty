class_name SpecificMovementEvent extends Event

enum MovementType {
	UNDO,
	START
}

func _init(text: String, movement_type: MovementType):
	self.text = text
