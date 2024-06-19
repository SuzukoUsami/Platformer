extends Node2D

var coin_value: int = 5

func _on_area_2d_body_entered(_body):
	print("bronze")
	queue_free()
