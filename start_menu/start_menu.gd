extends CanvasLayer

func _on_start_pressed():
	var optionButton = $StartMenuePanel/OptionButton
	var id = optionButton.get_item_id(optionButton.selected)
	print(id) #0=4 Player. 1=3 Player, 2=2 Player
	self.visible=false


func _on_option_button_item_selected(index):
	print("OptionButton item selected:", index)
