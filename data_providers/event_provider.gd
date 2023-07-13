class_name EventProvider extends JSONLoader

var file_path = "res://data_providers/data/events.json"

var events

# Es werden von den Get - Funktionen immer 
# 		[0] ein String (der Text zum Event) und
# 		[1] ein Wert (im Zusammenhang zum Event) 
# 	als liste zurück gegeben

func _init():
	events = load_json_file(file_path)
	assert(events != null, "No events found.")
	for event in events:
		print(event)
	print(get_event_coins_gained())
	print(get_event_duel_percentage(13))
	print(get_event_switch_with_other_player("Kevin"))
		
func get_event_coins_lost():
	var event = events["coins"]["textLost"]
	return event[randi() % event.size()]
	
func get_event_coins_gained():
	var event = events["coins"]["textGain"]
	return event[randi() % event.size()]

func get_event_percentage_lost():
	var event = events["percentage"]["textLost"]
	return event[randi() % event.size()]
	
func get_event_percentage_gained():
	var event = events["percentage"]["textGain"]
	return event[randi() % event.size()]

func get_event_roll_dice_again():
	var event = events["rollDice"]["textAgain"]
	return event[randi() % event.size()]

func get_event_roll_dice_twice():
	var event = events["rollDice"]["textTwice"]
	return event[randi() % event.size()]

func get_event_move_forward():
	var event = events["move"]["textForward"]
	return event[randi() % event.size()]

func get_event_move_backwards():
	var event = events["move"]["textBackwards"]
	return event[randi() % event.size()]

func get_event_move_undo():
	var event = events["move"]["textUndo"]
	return event[randi() % event.size()]

func get_event_move_to_start():
	var event = events["move"]["textStart"]
	return event[randi() % event.size()]

func get_event_switch_with_other_player(player:String):
	var event = events["switchPositions"]["text"]
	return event.replace("{0}", player)

func get_event_duel_coins(coins:int):
	var event = events["duel"]["coins"]["text"]
	return event.replace("{0}", str(coins))
	
func get_event_duel_percentage(percentage:int):
	var event = events["duel"]["coins"]["text"]
	return event.replace("{0}", str(percentage))

func get_event_duel_dice_number():
	return events["duel"]["dice_number"]["text"]

func get_event_steal(stealed_from:String):
	var event = events["stealTurn"]["text"].replace("{0}", stealed_from)
	return event[randi() % event.size()]
	
func get_event_sabotage_safe():
	return events["sabotageSafeCard"]["text"]













