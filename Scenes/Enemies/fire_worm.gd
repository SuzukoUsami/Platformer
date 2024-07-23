extends Node2D

var active: bool = false
var shoot: bool = true

signal fire_projectile(pos, direction)

func _process(_delta):
	if shoot == true:
		var marker_point = $ProjectileSpawnPosition.get_child(randi_range(0,1))
		var pos: Vector2 = marker_point.global_position
		var direction: Vector2 = (Globals.player_position - position).normalized()
		fire_projectile.emit(pos, direction)
		shoot = false
	pass

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
