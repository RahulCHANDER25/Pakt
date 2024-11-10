extends Node2D

@export var sky_ball_enemy: PackedScene
@export var flying_enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SkyBallTimer.wait_time = 0.5
	$SkyBallTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sky_ball_timer_timeout() -> void:
	var sky_ball = sky_ball_enemy.instantiate()

	sky_ball.position = Vector2(
		(get_viewport().get_camera_2d().global_position.x - get_window().size.x) + randf_range(0, get_viewport().size.y),
		get_viewport().get_camera_2d().global_position.y - (get_window().size.y)
	)
	add_child(sky_ball)

func spawn_fying_enemy(flying_enemy_info):
	pass
