extends Area2D
class_name HitboxComponent

signal going_to_die

@export var instant_death: bool = true

func _on_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		var y_delta = global_position.y - body.position.y
		if (y_delta > 40):
				body.bounce(1)
				
				if instant_death:
					get_parent().queue_free()
				else: 
					going_to_die.emit()
		else:
			body.hit_player()
