class_name EventHandler extends Resource

var file_path = "res://scripts/data/events.json"
var events: Array[Event]
var json_loader = JSONLoader.new()

func _init():
	var events_from_json = json_loader.load_json_file(file_path)["events"]
	assert(events_from_json != null, "No events found.")
	for event in events_from_json:
		var event_obj = Event.new()
		event_obj.event_description = event["event_description"]
		events.append(event_obj)
			
func get_event(index: int):
		return events[index]
