extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var auto_move_component = $AutoMoveComponent

var speed = 60

func _physics_process(delta):
	auto_move_component.handle_direction_switch()
	position.x += speed * delta * auto_move_component.get_direction()

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
