class_name CoinEvent extends Event

var change_amount: int


enum ChangeType { 
	LOST, 
	GAIN
}

func _init(text: String, change_amount: int, change_type: ChangeType):
	self.text = text % change_amount
	
	change_amount = abs(change_amount)
	self.change_amount = -1 * change_amount if change_type == ChangeType.LOST else change_amount
