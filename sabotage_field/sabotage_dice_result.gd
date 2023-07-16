extends CanvasLayer

@onready var label=$CanvasLayer/Panel/Label

signal finished

var player: Player
var action: Callable


func _on_button_pressed():
	await action.call()
	finished.emit()


func display(player: Player, dice_value):
	self.player = player
	visible = true

	var duel_50 = {
		"text": "Duell Einsatz: 50 Riesen",
		"action": func():
			var target = await get_target()
			var result = await run_duel(target)
			# match case over result
	}


	if (dice_value==7 || dice_value==8):
		result="Big Baller Duell Einsatz: halbes Vermögen"
		action = duel_big
	if (dice_value==9):
		result="Duell um Zug stehlen"
		action = steal_turn
	if (dice_value==10):
		result="Erhalt Sabotage Freikarte"
		action = sabotage_free_card
	if (dice_value==11):
		result="Eigentor Verlust: 50 Riesen"
		action = lose_50
	if (dice_value==12):
		result="Duell Würfelgeld \nWert:gewürfelte Anzahl Riesen*10"
		action = duel_roll
	
	label.set_text(result)
	
	return finished


func duel_50():
	var target = await get_target()


func duel_big():
	var target = await get_target()
	
	
func steal_turn():
	var target = await get_target()
	State.steal_turn(player, target)
	
	
func duel_roll():
	var target = await get_target()
	
	
func sabotage_free_card():
	player.sabotage_card = true


func lose_50():
	player.riesen -= 50
	
	
func get_target():
# Use select_target scene to get target
	pass


func run_duel(target):
# Execute the duel. the player is the attacker
# Return the result enum
	pass
