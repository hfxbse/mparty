extends CanvasLayer

signal finished(target)
var player: Player

const CONTAINER_SELECTOR = "GridContainer"


func display(player: Player):
	print("Choosing target")
	self.player = player
	
	for target in State.players:
		if target != player:
			if target.sabotage_card > 0:
				target.sabotage_card -= 1
			else: 
				var button = preload("res://select_target/target_button.tscn").instantiate()
				get_node(CONTAINER_SELECTOR).add_child(button)
				button.display(target).connect(_on_click)
	
	visible = true
	return finished


func _on_click(target):
	finished.emit(target)
