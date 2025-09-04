extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 900.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Horizontal movement
	var input_dir := Input.get_axis("ui_left", "ui_right")
	velocity.x = input_dir * speed

	# Flip sprite
	if input_dir != 0:
		anim.flip_h = input_dir < 0

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Play animations
	if not is_on_floor():
		anim.play("jump")
	elif input_dir != 0:
		anim.play("run")
	else:
		anim.play("idle")

	# Move the character
	move_and_slide()
