extends CanvasLayer

@onready var no_money_panel = $patentOfficeLabel/MoneyPanel
@onready var no_money_label = $patentOfficeLabel/MoneyPanel/NoMoney
@onready var patent_count_label = $patentOfficeLabel/PatentCountLabel

var player: Player
var cost_of_patent = 10
var patent_value = 5
var patent_count = 1

signal patent_office_done(done: bool)


func _on_patent_yes_pressed():
	if player.riesen < patent_count * cost_of_patent:
		no_money_label.add_theme_color_override("font_color", Color(1,0,0))
		no_money_panel.visible=true
		await get_tree().create_timer(1.5).timeout
		no_money_panel.visible=false
	else:
		player.riesen -= patent_count * cost_of_patent
		player.patente += patent_count * patent_value
		patent_office_done.emit(true)


func start_transaction(player: Player):
	self.player = player
	
	return patent_office_done


func _on_end_turn_pressed():
	patent_office_done.emit(true)


func _on_add_button_pressed():
	patent_count += 1
	patent_count_label.text = str(patent_count)
	print(patent_count)


func _on_subtract_button_pressed():
	patent_count -= 1
	patent_count_label.text = str(patent_count)
	print(patent_count)
