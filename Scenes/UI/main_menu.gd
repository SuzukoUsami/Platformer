extends Node


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Scenes/starting_level.tscn")


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level1.tscn")
