extends CanvasLayer

@onready var menu_button = $ActionMenu/CameraButton
@onready var stats_container = $Stats/StatsContainer
@onready var round_status_label = $Rounds/RoundStatus
@onready var max_rounds_label = $Rounds/MaxRounds
@onready var settings_menu_button = $Settings/SettingsMenuButton

var main_camera_selected = false

signal camera_menu_pressed(main_camera_selected: bool)
signal close_game_requested(is_close_requested: bool)


func _ready():
	settings_menu_button.get_popup().id_pressed.connect(on_settings_button_id_pressed)


func _on_camera_button_pressed():
	main_camera_selected = !main_camera_selected
	camera_menu_pressed.emit(main_camera_selected)


func update_player_stats(players):
	for child in stats_container.get_children():
		stats_container.remove_child(child)
		
	var counter = 1
	for player in players:
		var player_name_label = Label.new()
		player_name_label.text = "Spieler" + str(counter)
		var money_label = Label.new()
		money_label.text = str(player.riesen)
		
		stats_container.add_child(player_name_label)
		stats_container.add_child(money_label)		
		
		counter += 1
		
		
func update_round_count(num_rounds, max_rounds):
	round_status_label.text = str(num_rounds)
	max_rounds_label.text = str(max_rounds)
	
func on_settings_button_id_pressed(id: int):
	if id == 0:
		close_game_requested.emit(true)
