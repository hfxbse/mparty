class_name EventProvider extends JSONLoader

var file_path = "res://data_providers/events/events.json"

var events: Array[Event]


func _init():
	var events = load_json_file(file_path)
	assert(events != null, "Failed to load events.")

	add_coin_events(events["coins"]["lost"], CoinEvent.ChangeType.LOST)
	add_coin_events(events["coins"]["gain"], CoinEvent.ChangeType.GAIN)

	add_percentage_events(events["percentage"]["lost"], PercentageEvent.ChangeType.LOST)
	add_percentage_events(events["percentage"]["gain"], PercentageEvent.ChangeType.GAIN)

	add_relative_movement_events(events["move"]["forward"], RelativeMovementEvent.Direction.FORWARD)
	add_relative_movement_events(events["move"]["backward"], RelativeMovementEvent.Direction.BACKWARD)

	add_specific_movement_events(events["move"]["undo"], SpecificMovementEvent.MovementType.UNDO)
	add_specific_movement_events(events["move"]["start"], SpecificMovementEvent.MovementType.START)

	add_dice_roll_events(events["diceRoll"]["again"], DiceRollEvent.RollType.AGAIN)

	for event in self.events:
		print(event.text)


func get_random_event():
	return events[randi() % events.size()]


func add_coin_events(events: Array, change_type: CoinEvent.ChangeType):
	add_value_variated_events(events, func (text, variation): 
		return CoinEvent.new(text, variation["amount"], change_type)
	)


func add_percentage_events(events: Array, change_type: PercentageEvent.ChangeType):
	add_value_variated_events(events, func (text, variation): 
		return PercentageEvent.new(text, variation["percentage"], change_type)
	)


func add_relative_movement_events(events: Array, direction: RelativeMovementEvent.Direction):
	add_value_variated_events(events, func (text, variation): 
		return RelativeMovementEvent.new(text, variation["distance"], direction)
	)


func add_dice_roll_events(events: Array, type: DiceRollEvent.RollType):
	add_events(events, func(text):
		return DiceRollEvent.new(text, type)
	)


func add_specific_movement_events(events: Array, type: SpecificMovementEvent.MovementType):
	add_events(events, func(text):
		return SpecificMovementEvent.new(text, type)
	)


func add_value_variated_events(events: Array, event_factor: Callable):
	for variation in events:
		for text in variation["texts"]:
			self.events.append(event_factor.call(text, variation))


func add_events(events: Array, event_factor: Callable):
		for text in events:
			self.events.append(event_factor.call(text))
