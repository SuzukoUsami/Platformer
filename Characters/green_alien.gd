extends CharacterBody2D

# Vertical impulse applied to the character upon bouncing over a mob in meters per second.
@export var bounce_impulse = 16

var speed = 400.0
var jump_speed = -550.0



func hit():
	Globals.health -= 1


# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed
	

	move_and_slide()
	

