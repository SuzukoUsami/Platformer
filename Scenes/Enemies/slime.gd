extends Node2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down = $RayCastDown
@onready var sprite = $AnimatedSprite2D

#const shader = preload("res://Characters/green_alien.gdshader")

var speed = 60
var direction = -1

var auto_move: bool

func _ready():
	auto_move = get_meta("auto_move", true)

func _physics_process(delta):
	if ray_cast_left.is_colliding():
		switch_direction()
		
	if auto_move and not ray_cast_down.is_colliding():
		switch_direction()
	
	position.x += speed * delta * direction

func switch_direction() -> void:
	ray_cast_down.position.x *= -1
	ray_cast_left.rotate(PI)
	direction *= -1
	sprite.set_flip_h(not sprite.flip_h)

func _on_hitbox_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
			$AnimatedSprite2D.material.set_shader_parameter("progress", 0.6)
			$HitShaderTimer.start()
			body.bounce(1)
		else:
			body.hit_player()


func _on_hit_shader_timer_timeout():
	queue_free()
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
