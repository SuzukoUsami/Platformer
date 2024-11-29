extends CharacterBody2D

const ACCELERATION = 800
const FRICTION = 400
const MAX_SPEED = 300
const FALL_ACCELERATION = 2
const JUMP_SPEED = -650
enum {IDLE, WALK}
var state = IDLE

@export var bounce_impulse: int = 16
@export var knockback_power: int = 4000

@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_blend_space2d/blend_position",
	"parameters/walk/walk_blend_space2d/blend_position"
]

var animTree_state_keys = [
	"idle",
	"walk"
]

var vulnerability: bool = true

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$CanvasLayer.visible = true
	$CanvasLayer/AnimationPlayer.play("reveal")


func _physics_process(delta):
	move(delta)
	go_down(delta)
	handle_jump()
	animate()

func move(delta):
	var input_vector = Input.get_vector("left", "right", "up", "down")
	if input_vector == Vector2.ZERO:
		state = IDLE
		apply_friction(FRICTION * delta)
	else:
		state = WALK
		apply_movement(input_vector * ACCELERATION * delta)
		blend_position = input_vector
	move_and_slide()

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(MAX_SPEED)

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_paths[state], blend_position)

# Add the gravity.
func go_down(delta):
	if Input.is_action_pressed("down") and not is_on_floor:
		velocity.y += gravity * delta * FALL_ACCELERATION
	else:
		velocity.y += gravity * delta

func handle_jump():
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = JUMP_SPEED

func hit_player():
	if vulnerability:
		vulnerability = false
		$VulnerabilityTimer.start()
		#animation.play("hurt")
		Globals.health -= 1 #REMEMBER to change!!!
		#knockback()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.5)
		$HitShaderTimer.start()
		
	if Globals.health < 1:
		$CollisionPolygon2D.queue_free()

func _on_hit_shader_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

func _on_vulnerability_timer_timeout():
	vulnerability = true
	




#OLD ANIMATION AND STUFF/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#@onready var animation = $AnimatedSprite2D
#
## Vertical impulse applied to the character upon bouncing over a mob in meters per second.
#@export var bounce_impulse = 16
#@export var knockback_power: int = 4000
#
#var speed = 40
#var max_speed = 400
#var jump_speed = -550.0
#var fall_acceleration = 2
#var vulnerability: bool = true
#
#
#func _ready():
	#$CanvasLayer.visible = true
	#$CanvasLayer/AnimationPlayer.play("reveal")
#
#
#func _process(_delta):
	#pass
#
#
#func hit_player():
	#if vulnerability:
		#vulnerability = false
		#$VulnerabilityTimer.start()
		##animation.play("hurt")
		#Globals.health -= 0 #Remember to change!!!
		#knockback()
		#$AnimatedSprite2D.material.set_shader_parameter("progress", 0.5)
		#$HitShaderTimer.start()
		#
	#if Globals.health < 1:
		#$CollisionPolygon2D.queue_free()
#
#
## Get the gravity from the project settings so you can sync with rigid body nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#func bounce(bounce_factor):
	#velocity.y = jump_speed * bounce_factor
	#
#
#func _physics_process(delta):
	#
	#var go_right = Input.is_action_pressed("right")
	#var go_left = Input.is_action_pressed("left")
	#var on_floor = is_on_floor_only()
	#var go_down = Input.is_action_pressed("down")
	#var jump = Input.is_action_pressed("up")
	#var stop_right = Input.is_action_just_released("right")
	#var stop_left = Input.is_action_just_released("left")
#
	#
	#if go_right and on_floor or go_left and on_floor:
		#animation.play("walk")
	#elif stop_right and on_floor or stop_left and on_floor:
	##else:
		#animation.play("idle")
#
#
	## Add the gravity.
#
	#if go_down and not on_floor:
		#velocity.y += gravity * delta * fall_acceleration
		#animation.play("down")
	#else:
		#velocity.y += gravity * delta
		##animation.play("jump")
#
#
	## Handle Jump.
#
	#if jump and on_floor:
		#velocity.y = jump_speed
		#animation.play("jump")
	#
	#
	## Get the input direction.
	#var direction = Input.get_axis("left", "right")
	#if direction > 0:
		#velocity.x = clamp(velocity.x + direction * speed, -max_speed, max_speed)
		#animation.set_flip_h(false)
	#elif direction < 0:
		#velocity.x = clamp(velocity.x + direction * speed, -max_speed, max_speed)
		#animation.set_flip_h(true)
	#else:
		#velocity.x *= 0.8
	#
	##print_debug(velocity.y)
		#
	#if velocity.x >= -16 and velocity.x <= 16 and velocity.y == 0:
		#print_debug("KITKU")
		#animation.play("idle")
#
	#
	#Globals.player_position = global_position
	#move_and_slide()
#
#func knockback():
	#var knockback_direction = Vector2(velocity.normalized().x * -knockback_power, jump_speed * .8)
	#velocity = knockback_direction
#
#func _on_hit_shader_timer_timeout():
	#$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
#
#
#func _on_vulnerability_timer_timeout():
	#vulnerability = true
	#
