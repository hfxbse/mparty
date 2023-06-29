extends Control

signal selected_difficulty(difficulty: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_difficulty_1_pressed():
	var difficulty=0;
	#questionEasy();
	var callQuestionHandler = $question_panel/question_panel.gd;
	callQuestionHandler._ready();
	pass # Replace with function body.


func _on_difficulty_2_pressed():
	var difficulty=1;
	#questionMiddle();
	var callQuestionHandler = $question_panel/question_panel.gd;
	callQuestionHandler._ready();
	pass # Replace with function body.


func _on_difficulty_3_pressed():
	var difficulty=2;
	#questionHard();
	var callQuestionHandler = $question_panel/question_panel.gd;
	callQuestionHandler._ready();
	pass # Replace with function body.
