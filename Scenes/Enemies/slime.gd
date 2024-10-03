extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var auto_move_component = $AutoMoveComponent

var speed = 60

func _physics_process(delta):
	auto_move_component.handle_direction_switch()
	position.x += speed * delta * auto_move_component.get_direction()


func _on_hitbox_component_going_to_die():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0.6)
	$HitShaderTimer.start()

func _on_hit_shader_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
	queue_free()
	
