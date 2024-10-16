extends Node2D


func _on_area_2d_body_entered(_body):
	Globals.coins_amount += 3
	queue_free()
