class_name EventProvider extends JSONLoader

var file_path = "res://data_providers/data/events.json"

var events

func _init():
	events = load_json_file(file_path)
	assert(events != null, "No events found.")
	print(get_event_coins(Event.MoneyType.GAIN))


func get_event_coins(action: Event.MoneyType):
	var e
	match(action):
		Event.MoneyType.GAIN:
			e = events["coins"]["textLost"]
		Event.MoneyType.LOST:
			e = events["coins"]["textGain"]
	return e[randi() % e.size()]
		
		
func get_event_percentage(action: Event.MoneyType):
	var e
	match(action):
		Event.MoneyType.GAIN:
			e = events["percentage"]["textLost"]
		Event.MoneyType.LOST:
			e = events["percentage"]["textGain"]
	return e[randi() % e.size()]
	

func get_event_diceroll(action: Event.DiceRoll):
	var e
	match(action):
		Event.DiceRoll.AGAIN:
			e = events["rollDice"]["textAgain"]
		Event.DiceRoll.TWICE:
			e = events["rollDice"]["textTwice"]
	return e[randi() % e.size()]


func get_event_move(move: Event.MoveType):
	var e
	match(move):
		Event.MoveType.FORWARD:
			e = events["move"]["textForward"]
		Event.MoveType.BACKWARDS:
			e = events["move"]["textBackwards"]
		Event.MoveType.UNDO:
			e = events["move"]["textUndo"]
		Event.MoveType.TOSTART:
			e = events["move"]["textStart"]
	return e[randi() % e.size()]


func get_event_switch_with_other_player(player: String):
	var event = events["switchPositions"]["text"]
	return event.replace("{0}", player)


func get_event_duel(duel: Event.DuelType):
	var value = randi() % 150
	
	var event
	match(duel):
		Event.DuelType.COINS: 
			event = events["duel"]["coins"]["text"]
		Event.DuelType.PERCENTAGE:
			event = events["duel"]["percentage"]["text"]
		Event.DuelType.DICE_NUMBER:
			# this event is not gonna be implemented until monday
			# in agreement with the management
			event = events["duel"]["dice_number"]["text"]
	return event.replace("{0}", str(value))


func get_event_steal(stealed_from:String):
	var event = events["stealTurn"]["text"].replace("{0}", stealed_from)
	return event[randi() % event.size()]


func get_event_sabotage_safe():
	return events["sabotageSafeCard"]["text"]
