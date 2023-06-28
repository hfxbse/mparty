extends Panel

@onready var animation = $AnimationPlayer
@onready var label = $Label
@onready var button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var random = randi_range(1,12)
	
	animation.play("popUpScale")
	#event based on random number, navigate to correct method
	label.set_text(String("%d" % random))
	pass # Replace with function body.
