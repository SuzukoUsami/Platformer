extends Node2D

var active: bool = false


func _on_notice_area_body_entered(_body):
	active = true


func _on_notice_area_body_exited(_body):
	active = false


func _on_hit_area_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
			queue_free()
			body.bounce(1)
		else:
			body.hit_player()
