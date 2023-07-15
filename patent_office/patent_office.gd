extends CanvasLayer

@onready var panelNoMoney = $patentOfficeLabel/MoneyPanel
@onready var noMoneyLabel = $patentOfficeLabel/MoneyPanel/NoMoney

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_patent_yes_pressed():
	#buy patent communication with patent and money storage
	var moneyLeft = 0;
	var kost_of_patent = 10
	var patent_value = 5
	
	#get money and patent, money-10, patent+10
	
	if (moneyLeft==0):
		noMoneyLabel.add_theme_color_override("font_color", Color(1,0,0))
		panelNoMoney.visible=true;
		#end turn

func _on_end_turn_pressed():
	#end turn
	pass # Replace with function body.
