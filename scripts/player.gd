extends CharacterBody2D

signal hit

var SPEED = 300.0 + (PlayerStats.mapStats["magic"] * 4)
var JUMP_VELOCITY = -550.0 + ((PlayerStats.mapStats["strength"] * 8) * -1)

func _ready() -> void:
	pass

func _process(delta):
	if (global_position.x < get_viewport().get_camera_2d().global_position.x - (get_window().size.x / 2)):
		global_position.x = get_viewport().get_camera_2d().global_position.x - (get_window().size.x / 2)

func _physics_process(delta: float) -> void:
	if global_position.y > 500:
		get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")

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
