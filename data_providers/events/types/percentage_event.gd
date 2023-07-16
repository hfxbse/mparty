class_name PercentageEvent extends Event

var change_amount: int

enum ChangeType { 
	LOST, 
	GAIN
}


func _init(text: String, change_amount: float, change_type: ChangeType):
	self.text = text % (change_amount * 100)

	change_type = abs(change_amount)
	self.change_amount = 1 - change_amount if change_type == ChangeType.LOST else 1 + change_amount
