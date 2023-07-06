extends Panel

@onready var label = $Label
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	var person = "sdafasdf";
	label.set_text(String("%s wins" % person));


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	self.visible = false
