extends Node2D

@export var sky_ball_enemy: PackedScene
@export var box_enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BoxTimer.wait_time = 2
	$BoxTimer.start()

	$SkyBallTimer.wait_time = 0.75
	$SkyBallTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sky_ball_timer_timeout() -> void:
	var sky_ball = sky_ball_enemy.instantiate()

	var view = get_viewport()
	sky_ball.position = Vector2(
		(view.get_camera_2d().global_position.x - get_window().size.x) + randf_range(view.size.x / 2, view.size.x),
		view.get_camera_2d().global_position.y - (get_window().size.y)
	)
	add_child(sky_ball)


func _on_box_timer_timeout() -> void:
	var box = box_enemy_scene.instantiate()

	var view = get_viewport()
	box.position = Vector2(
		(view.get_camera_2d().global_position.x - get_window().size.x) + randf_range(3 * view.size.x / 4, view.size.x),
		view.get_camera_2d().global_position.y - (get_window().size.y)
	)
	add_child(box)
