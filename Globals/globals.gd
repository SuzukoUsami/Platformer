extends Node

signal amount_change
signal health_change

const PLAYER_NAME = "GreenAlien"

var current_level: String = "res://Scenes/Levels/level1.tscn"

var health: int = 6:
	set(value):
		health = value
		health_change.emit()

var coins_amount: int = 100:
	set(value):
		coins_amount = value
		amount_change.emit()

func change_level(target_level: String) -> void:
	var err = get_tree().change_scene_to_file(target_level)
	if err != OK:
		printerr("Can't change scene, error code: ", err)
		return
	coins_amount = 0
	health = 6
	current_level = target_level
	#print("play transition animations")
	
var target

func save_game():
	#print(last_completed_level)
	var config = ConfigFile.new()
	config.set_value("Player1", "last_level", current_level)
	var err = config.save("user://saves.cfg")
	print_debug("saved", err)
	if err != OK:
		printerr("Can't save config, error code: ", err, " current_level: ", current_level)
		return
	
func load_game():
	print("load")

	var config = ConfigFile.new()
	var err = config.load("user://saves.cfg")
	if err != OK:
		printerr("Can't load config, error code: ", err)

	var last_save = config.get_value("Player1", "last_level", "res://Scenes/Levels/level1.tscn")
	
	print(last_save)

	change_level(last_save)
		
var player_position: Vector2
var door_position: Vector2
