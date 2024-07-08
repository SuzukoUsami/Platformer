extends CharacterBody2D

var speed = 175
var active: bool = false

func _process(_delta):
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		print(direction)
		#look_at(Globals.player_position)


func _on_notice_area_body_entered(_body):
	active = true


func _on_hit_area_body_entered(body):
	if (body.name == "GreenAlien"):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
			queue_free()
			body.bounce(1)
		else:
			Globals.hit_player(body)



