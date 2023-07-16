extends CanvasLayer

@onready var option_button = $StartMenuePanel/OptionButton
@onready var round_counter = $RoundCounter


var player_count = 4
var rounds_count = 10:
	set(number):
		if number != rounds_count:
			rounds_count = number
			
			if round_counter:
				round_counter.text = str(rounds_count)

signal start_params(num_rounds: int, player_count: int)

func _on_start_pressed():
	var id = option_button.get_item_id(option_button.selected)
	
	start_params.emit(rounds_count, player_count)


func _on_option_button_item_selected(index):
	player_count = 4 - index


func _on_add_rounds_pressed():
	rounds_count += 1 


func _on_subtract_rounds_pressed():
	rounds_count -= 1 
