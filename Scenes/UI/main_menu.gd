extends Node


func _on_tutorial_pressed():
	Globals.change_level("res://Scenes/Levels/tutorial.tscn")


func _on_level_1_pressed():
	Globals.change_level("res://Scenes/Levels/level1.tscn")


func _on_level_2_pressed():
	Globals.change_level("res://Scenes/Levels/level2.tscn")


func _on_level_3_pressed():
	Globals.change_level("res://Scenes/Levels/level3.tscn")
