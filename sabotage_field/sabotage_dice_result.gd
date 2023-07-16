extends CanvasLayer

@onready var label=$CanvasLayer/Panel/Label

signal finished

var player: Player
var action: Callable


func _on_button_pressed():
	visible = false
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
	
	var duell_big = {
		"text": "Big Baller Duell Einsatz: halbes Vermögen",
		"action": func():
			var target = await get_target()
			var result = await run_duel(target)
			# match case over result
	}
	
	var duell_roll = {
		"text": "Duell Würfelgeld \nWert:gewürfelte Anzahl Riesen*10",
		"action": func():
			var target = await get_target()
			var result = await run_duel(target)
			# match case over result
	}

	var steal_turn = {
		"text": "Duell um Zug stehlen",
		"action": func():
			var target = await get_target()
			var result = await run_duel(target)
			# match case over result
	}
	
	var sabotag_card = {
		"text": "Erhalt Sabotage Freikarte",
		"action": func():
			player.sabotage_card += 1
	}
	
	var lose_50 = {
		"text": "Eigentor Verlust: 50 Riesen",
		"action": func():
			player.riesen -= 50
	}

	var result_array = [duel_50, duel_50, duel_50, duel_50, duel_50, duel_50, duell_big, duell_big, steal_turn, sabotag_card, lose_50, duell_roll]
	var result = result_array[dice_value-1]
	label.set_text(result["text"])
	action = result["action"]
	
	return finished


func get_target():
# Use select_target scene to get target
	pass


func run_duel(target):
# Execute the duel. the player is the attacker
# Return the result enum
	pass
