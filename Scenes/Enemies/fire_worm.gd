extends Node2D



@onready var worm_sprite = $AnimatedSprite2D

var fire_projectile_scene: PackedScene = preload("res://Scenes/Projectiles/fire_projectile.tscn")

var active: bool = false
#var shoot: bool = true

func _ready():
	print_debug(active)

func  create_fire_projectile(pos, direction):
	var fire_projectile = fire_projectile_scene.instantiate()
	fire_projectile.position = pos
	fire_projectile.direction = direction
	$Projectiles.call_deferred("add_child", fire_projectile)
	

func _on_notice_area_body_entered(body):
	$ShootingTimer.start()
	if (body.name == Globals.PLAYER_NAME):
		active = true
		var marker_point = $ProjectileSpawnPosition.get_child(randi_range(0,1))
		var pos: Vector2 = marker_point.position
		var direction: Vector2 = (Globals.player_position - position).normalized()
		create_fire_projectile(pos, direction)


func _on_shooting_timer_timeout():
	if active == true:
		var marker_point = $ProjectileSpawnPosition.get_child(randi_range(0,1))
		var pos: Vector2 = marker_point.position
		var direction: Vector2 = (Globals.player_position - position).normalized()
		create_fire_projectile(pos, direction)



func _on_notice_area_body_exited(_body):
	active = false



func _on_hitbox_component_going_to_die():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0.6)
	$HitShaderTimer.start()


func _on_hit_shader_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
	queue_free()
