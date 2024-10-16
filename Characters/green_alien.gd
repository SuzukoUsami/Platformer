extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

# Vertical impulse applied to the character upon bouncing over a mob in meters per second.
@export var bounce_impulse = 16

@export var knockback_power: int = 4000

var speed = 40
var max_speed = 400
var jump_speed = -550.0
var fall_acceleration = 2
var vulnerability: bool = true

func _ready():
	$CanvasLayer.visible = true
	$CanvasLayer/AnimationPlayer.play("reveal")


func _process(_delta):
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		animation.play("walk")
	elif Input.is_action_just_released("right") or Input.is_action_just_released("left"):
		animation.stop()
		

	if Input.is_action_just_pressed("right"):
		animation.set_flip_h(false)
	elif Input.is_action_just_pressed("left"):
		animation.set_flip_h(true)

func hit_player():
	if vulnerability:
		vulnerability = false
		Globals.health -= 1
		knockback()
		$VulnerabilityTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.5)
		$HitShaderTimer.start()
		
	if Globals.health < 1:
		$CollisionPolygon2D.queue_free()


# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func bounce(bounce_factor):
	velocity.y = jump_speed * bounce_factor
	

func _physics_process(delta):
	
	# Add the gravity.
	if Input.is_action_pressed("down") and not is_on_floor():
		velocity.y += gravity * delta * fall_acceleration
	else:
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("up") and is_on_floor():
		velocity.y = jump_speed
	
	# Get the input direction.
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		var direction = Input.get_axis("left", "right")
		velocity.x = clamp(velocity.x + direction * speed, -max_speed, max_speed)
	else:
		velocity.x *= 0.8
		pass
	
	Globals.player_position = global_position
	move_and_slide()

func knockback():
	var knockback_direction = Vector2(velocity.normalized().x * -knockback_power, jump_speed * .8)
	velocity = knockback_direction

func _on_hit_shader_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)


func _on_vulnerability_timer_timeout():
	vulnerability = true
