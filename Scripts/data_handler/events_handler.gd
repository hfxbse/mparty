class_name EventHandler extends Resource

var file_path = "res://Scripts/data/events.json"
var events: Array[Event]
var json_loader = JSONLoader.new()

func _init():
	var events_from_json = json_loader.load_json_file(file_path)["events"]
	if(events_from_json != null):
		for event in events_from_json:
			var event_obj = Event.new()
			event_obj.set_event_description(event["event_description"])
			events.append(event_obj)
	else:
		print("Couldn't load events.")
			
func get_event(index: int):
	if(index >= 0 and index < events.size()):
		return events[0]
	else:
		print("Event index is out of bounds.")
		return null
