extends PathFollow2D


var speed = 0.1

func _process(delta):
	progress_ratio += speed * delta
	


func _on_hitbox_body_entered(body):
	if (body.name == "GreenAlien"):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
			queue_free()
			body.bounce(1)
		else:
			Globals.hit_player(body)
	
