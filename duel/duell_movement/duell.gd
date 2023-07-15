extends CanvasLayer

var attacker: Player
var target: Player

var attacker_points: int
var target_points: int

enum DuelEndings {
	ATTACKER_WINS,
	ATTACKER_LOSES,
	DRAW
}

signal duel_result(ending: DuelEndings)
	
func _on_start_button_pressed():
	var counter = 0
	print(attacker_points == target_points)
	
	while attacker_points == target_points && counter < 3:
		counter += 1
		attacker_points += await start_question(attacker)
		target_points += await start_question(target)
		
	if attacker_points > target_points:
		duel_result.emit(DuelEndings.ATTACKER_WINS)
	elif attacker_points < target_points:
		duel_result.emit(DuelEndings.ATTACKER_LOSES)
	else:
		duel_result.emit(DuelEndings.DRAW)


func start_duel(attacker: Player, target: Player):
	self.attacker = attacker
	self.target = target


func start_question(player: Player):
	var question_panel = preload("res://question_panel/question_panel.tscn").instantiate()
	var question_difficulty = preload("res://question_difficulty/question_difficulty.tscn").instantiate()
	
	add_child(question_difficulty)
	var difficulty = await question_difficulty.difficulty
	await remove_child(question_difficulty)
	
	add_child(question_panel)
	question_panel.player_name = player.player_name
	var question_result = await question_panel.display_question(difficulty)
	await get_tree().create_timer(1.5).timeout
	remove_child(question_panel)
	
	return 1 if question_result else 0


func _on_duel_result(ending):
	match ending:
		DuelEndings.ATTACKER_WINS:
			print("ATTACKER_WINS")
		DuelEndings.ATTACKER_LOSES:
			print("ATTACKER_LOSES")
		DuelEndings.DRAW:
			print("DRAW")
