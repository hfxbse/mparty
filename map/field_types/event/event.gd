extends Node

@export var field_theme_override : FieldTheme

signal display_event_text(event_text: String)

func _ready():
	event(Player.new())

func event(player : Player):
	var event_provider = preload("res://data_providers/resources/event_provider.tres")
	var event_methods = event_provider.get_method_list().filter(func(object): return object["name"].contains("get_event"))
	var random_event = event_methods[randi() % event_methods.size()]
	var event_text
		
	if random_event["name"].contains("coins_gained"):
		print(event_provider.call(random_event["name"]))
		event_text = event_provider.call(random_event["name"])[0]
		print(random_event)
	elif random_event["name"].contains("coins_lost"):
		print(event_provider.call(random_event["name"]))
		print(random_event)

	display_event_text.emit(event_text)
