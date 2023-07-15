extends CanvasLayer

signal terminate(target)
var player: Player


func display(player: Player):
	print("Choosing target")
	self.player = player
	
	for target in State.players:
		if target != player:
			if target.sabotage_card:
				target.sabotage_card = false
			else: 
				var button = preload("res://sabotage_field/target_button.tscn").instantiate()
				$GridContainer.add_child(button)
				button.display(target).connect(_on_click)
	
	visible = true
	return terminate


func _on_click(target):
	terminate.emit(target)
