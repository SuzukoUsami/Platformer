extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var notice_timer = $NoticeTimer
@onready var hiding_timer = $HidingTimer
@onready var auto_move_component = $AutoMoveComponent

var speed: int = 40
var is_hiding: bool = false

func _physics_process(delta):
	auto_move_component.handle_direction_switch()
		
	if not is_hiding:
		position.x += speed * delta * auto_move_component.get_direction()

func _on_hitbox_component_going_to_die():
	if not is_hiding:
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.6)
		$HitShaderTimer.start()

func _on_notice_area_body_entered(body):
	if is_queued_for_deletion():
		return
	if (body.name == Globals.PLAYER_NAME):
		notice_timer.start()
		pass

func _on_notice_area_body_exited(_body):
	if is_queued_for_deletion():
		return
	notice_timer.stop()
	hiding_timer.start()

func _on_notice_timer_timeout():
	if is_queued_for_deletion():
		return
	is_hiding = true
	sprite.play("hidden")

func _on_hiding_timer_timeout():
	if is_queued_for_deletion():
		return
	is_hiding = false
	sprite.play("walk")


func _on_hit_shader_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
	queue_free()
