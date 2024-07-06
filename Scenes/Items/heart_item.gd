extends Node2D

var heart_item_value = 1


func _on_area_2d_body_entered(_body):
	if Globals.health <= 5:
		Globals.health += 1
		queue_free()
