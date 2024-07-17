extends Node2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_down_left = $RayCastDownLeft
@onready var ray_cast_down_right = $RayCastDownRight
@onready var sprite = $Sprite2D
@onready var notice_timer = $NoticeTimer
@onready var hiding_timer = $HidingTimer

const SNAIL_WALK_1 = preload("res://graphics/Platformer Art Deluxe/Base pack/Enemies/snailWalk1.png")
const SNAIL_SHELL = preload("res://graphics/Platformer Art Deluxe/Base pack/Enemies/snailShell.png")

var speed: int = 40
var direction: int = -1
var is_hiding: bool = false

var auto_move: bool

func _ready():
	auto_move = get_meta("auto_move", true)

func _process(delta):
	if ray_cast_right.is_colliding() or ray_cast_left.is_colliding():
		switch_direction()
		
	if auto_move and (not ray_cast_down_left.is_colliding() or not ray_cast_down_right.is_colliding()):
			switch_direction()
		
	if not is_hiding:
		position.x += speed * delta * direction

func switch_direction() -> void:
	direction *= -1
	sprite.set_flip_h(not sprite.flip_h)

func _on_hit_box_body_entered(body):
	if (body.name == Globals.PLAYER_NAME and not is_hiding):
		var y_delta = position.y - body.position.y
		if (y_delta > 40):
				body.bounce(1)
				queue_free()
		else:
			body.hit_player()

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
	sprite.texture = SNAIL_SHELL

func _on_hiding_timer_timeout():
	if is_queued_for_deletion():
		return
	is_hiding = false
	sprite.texture = SNAIL_WALK_1



