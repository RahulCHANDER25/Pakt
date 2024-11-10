extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

func _ready() -> void:
	pass

func _process(delta):

	print("X camera: ", get_viewport().get_camera_2d().global_position.x, " | player: ", global_position.x, " | window: ", get_window().size.x)
	print("Y camera: ", get_viewport().get_camera_2d().global_position.y, " | player: ", global_position.y, " | window: ", get_window().size.y)
	if (global_position.x < get_viewport().get_camera_2d().global_position.x - (get_window().size.x / 2)):
		global_position.x = get_viewport().get_camera_2d().global_position.x - (get_window().size.x / 2)
	#if (position.x > get_viewport().get_camera_2d().global_position.x + get_window().size.x / 2):
		#position.x = get_viewport().get_camera_2d().global_position.x + get_window().size.x / 2
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("go_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
