extends Node2D

var coin_value: int = 15

func _on_area_2d_body_entered(_body):
	print("gold")
	queue_free()
