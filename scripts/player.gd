extends CharacterBody2D

signal hit

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

func _ready() -> void:
	pass

func _process(delta):
	if (global_position.x < get_viewport().get_camera_2d().global_position.x - (get_window().size.x / 2)):
		global_position.x = get_viewport().get_camera_2d().global_position.x - (get_window().size.x / 2)

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


func _on_player_area_2d_hit() -> void:
	PlayerStats.mapStats["health"] -= 1
	print("HP: %d" % PlayerStats.mapStats["health"])
	if PlayerStats.mapStats["health"] <= 0:
		print("DEAD")
	pass # Replace with function body.
