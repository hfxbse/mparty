extends CanvasLayer

signal terminate(target)
var player: Player

@onready var container = $GridContainer


func display(player: Player):
	print("Choosing target")
	self.player = player
	
	for target in State.players:
		if target != player:
			if target.sabotage_card:
				target.sabotage_card = false
			else: 
				var button = preload("res://select_target/target_button.tscn").instantiate()
				container.add_child(button)
				button.display(target).connect(_on_click)
	
	visible = true
	return terminate


func _on_click(target):
	terminate.emit(target)
