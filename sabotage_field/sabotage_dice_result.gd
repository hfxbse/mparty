extends Control

@onready var label=$CanvasLayer/Panel/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var result="abc"
	label.set_text(result)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	self.visible = false
