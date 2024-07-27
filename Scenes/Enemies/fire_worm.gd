extends Node2D

var fire_projectile_scene: PackedScene = preload("res://Scenes/Projectiles/fire_projectile.tscn")

var active: bool = false
var shoot: bool = true

func _ready():
	pass

func  create_fire_projectile(pos, direction):
	var fire_projectile = fire_projectile_scene.instantiate()
	fire_projectile.position = pos
	fire_projectile.direction = direction
	$Projectiles.call_deferred("add_child", fire_projectile)

func _on_notice_area_body_entered(_body):
	active = true
	if shoot == true:
		var marker_point = $ProjectileSpawnPosition.get_child(randi_range(0,1))
		var pos: Vector2 = marker_point.position
		var direction: Vector2 = (Globals.player_position - position).normalized()
		create_fire_projectile(pos, direction)
		shoot = false

func _on_notice_area_body_exited(_body):
	active = false
	shoot = true

func _on_hit_area_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
			queue_free()
			body.bounce(1)
		else:
			body.hit_player()
