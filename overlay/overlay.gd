extends CanvasLayer

@onready var menu_button = $ActionMenu/CameraButton
@onready var stats_container = $Stats/StatsContainer
@onready var round_status_label = $Rounds/RoundStatus
@onready var max_rounds_label = $Rounds/MaxRounds
@onready var settings_menu_button = $Settings/SettingsMenuButton

var main_camera_selected = false

signal camera_menu_pressed(main_camera_selected: bool)

func _on_camera_button_pressed():
	main_camera_selected = !main_camera_selected
	camera_menu_pressed.emit(main_camera_selected)


func update_player_stats(current_player, players):
	for child in stats_container.get_children():
		stats_container.remove_child(child)
		
	var counter = 1
	for player in players:
		var player_name_label = Label.new()
		player_name_label.text = "Spieler " + str(counter) + ":"
		if player == current_player:
			player_name_label.add_theme_color_override("font_color", Color(100, 0, 0))
		var money_label = Label.new()
		money_label.text = str(player.riesen) + " R" + " | " + str(player.patente) + " P"
		
		stats_container.add_child(player_name_label)
		stats_container.add_child(money_label)		
		
		counter += 1
		
		
func update_round_count(num_rounds, max_rounds):
	round_status_label.text = str(num_rounds)
	max_rounds_label.text = str(max_rounds)
