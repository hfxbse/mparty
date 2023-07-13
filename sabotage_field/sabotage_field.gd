extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var responseDice=1;
	var result;
	if (responseDice<=6):
		result="Duell Einsatz: 50 Riesen"
	if (responseDice==7||8):
		result="Big Baller Duell Einsatz: halbes Vermögen"
	if (responseDice==9):
		result="Duell um Zug stehlen"
	if (responseDice==10):
		result="Erhalt Sabotage Freikarte"
	if (responseDice==11):
		result="Eigentor Verlust: 50 Riesen"
	if (responseDice==12):
		result="Duell Würfelgeld \nWert:gewürfelte Anzahl Riesen*10"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	self.visible = false
