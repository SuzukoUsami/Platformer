extends CharacterBody2D

@onready var sprite_2d = $AnimatedSprite2D
@onready var particles = $GPUParticles2D

var speed = 175
var active: bool = false

func _process(_delta):
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		
	if Globals.player_position.x - position.x >= 0:
		sprite_2d.set_flip_h(true)
	elif Globals.player_position.x - position.x <= 0:
		sprite_2d.set_flip_h(false)



func _on_notice_area_body_entered(body):
	if (body.name == Globals.PLAYER_NAME):
		active = true
		particles.emitting = true


func _on_hitbox_component_going_to_die():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0.6)
	$HitShaderTimer.start()


func _on_hit_shader_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
	queue_free()
