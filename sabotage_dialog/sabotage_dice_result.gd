extends CanvasLayer

@onready var label = $CanvasLayer/Panel/Label

signal finished(action: Callable)

var player: Player
var action: Callable


func _on_button_pressed():
	hide()
	finished.emit(action)


var duel_50 = {
	"text": "Duell Einsatz: 50 Riesen",
	"action": func(player, tree):
		var target = await get_target(tree)
		var result = await run_duel(target, tree)
		apply_duel_outcome(player, target, 50, result)
}

var duell_big = {
	"text": "Big Baller Duell Einsatz: halbes Vermögen",
	"action": func(player, tree):
		var target = await get_target(tree)
		var result = await run_duel(target, tree)
		apply_duel_outcome(player, target, min(player.riesen, target.riesen) / 2, result)
}

var duell_roll = {
	"text": "Duell Würfelgeld \nWert:gewürfelte Anzahl Riesen*10",
	"action": func(player, tree):
		var target = await get_target(tree)
		var bet_amount = await roll_dice(tree)
		var result = await run_duel(target, tree)
		apply_duel_outcome(player, target, bet_amount, result)
}

var steal_turn = {
	"text": "Duell um Zug stehlen",
	"action": func(player, tree):
		var target = await get_target(tree)
		var result = await run_duel(target, tree)
		if result == Duel.DuelEndings.ATTACKER_WINS:
			State.steal_turn(player, target)
}

var sabotag_card = {
	"text": "Erhalt Sabotage Freikarte",
	"action": func(player, tree):
		player.sabotage_card += 1
}

var lose_50 = {
	"text": "Eigentor Verlust: 50 Riesen",
	"action": func(player, tree):
		player.riesen -= 50
}

var result_array = [duel_50, duel_50, duel_50, duel_50, duel_50, duel_50, duell_big, duell_big, steal_turn, sabotag_card, lose_50, duell_roll]


func display(player: Player, dice_value):
	self.player = player
	visible = true

	var result = result_array[dice_value-1]
	label.set_text(result["text"])
	action = result["action"]
	
	return finished


func get_target(tree):
	var selector = preload("res://select_target/select_target.tscn").instantiate()
	tree.add_child(selector)
	var target = await selector.display(player)
	tree.remove_child(selector)
	return target


func run_duel(target, tree):
	var duel_panel = preload("res://duel/overtaking_duell.tscn").instantiate()
	tree.add_child(duel_panel)
	var result = await duel_panel.start_duel(player, target)
	tree.remove_child(duel_panel)
	return result


func apply_duel_outcome(attacker, target, bet_amount, result):
	if result == Duel.DuelEndings.ATTACKER_LOSES:
		bet_amount *= -1
	elif result == Duel.DuelEndings.DRAW:
		bet_amount *= 0
	
	attacker.riesen += bet_amount
	target.riesen -= bet_amount


func roll_dice(tree):
	var dice_menu = preload("res://dice/dice.tscn").instantiate()
	tree.add_child(dice_menu)
	
	var dice_value = await dice_menu.dice_number
	tree.remove_child(dice_menu)
	
	return dice_value

