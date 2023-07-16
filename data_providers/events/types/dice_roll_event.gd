class_name DiceRollEvent extends Event

enum RollType {
	AGAIN,
	TWICE
}

func _init(text: String, roll_type: RollType):
	self.text = text
