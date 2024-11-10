extends Node2D

@export var sky_ball_enemy: PackedScene
@export var box_enemy_scene: PackedScene

func refresh(node, key, value):
	PlayerStats.mapStats[key] = value
	node.text = str(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BoxTimer.wait_time = 2 * abs((PlayerStats.mapStats["fame"] / 20))
	$BoxTimer.start()

	$SkyBallTimer.wait_time = 0.5 * abs((PlayerStats.mapStats["fame"] / 20))
	$SkyBallTimer.start()

	refresh($HUD/GUI/GameIcons/HeartCounter/Number, "health", PlayerStats.mapStats["health"])
	refresh($HUD/GUI/GameIcons/MagicCounter/Number, "magic", PlayerStats.mapStats["magic"])
	refresh($HUD/GUI/GameIcons/MoneyCounter/Number, "money", PlayerStats.mapStats["money"])
	refresh($HUD/GUI/GameIcons/FameCounter/Number, "fame", PlayerStats.mapStats["fame"])
	refresh($HUD/GUI/GameIcons/StrengthCounter/Number, "strength", PlayerStats.mapStats["strength"])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sky_ball_timer_timeout() -> void:
	var sky_ball = sky_ball_enemy.instantiate()

	var view = get_viewport()
	sky_ball.position = Vector2(
		(view.get_camera_2d().global_position.x - get_window().size.x) + randf_range(4 * view.size.x / 5, view.size.x),
		view.get_camera_2d().global_position.y - (get_window().size.y)
	)
	add_child(sky_ball)


func _on_box_timer_timeout() -> void:
	var box = box_enemy_scene.instantiate()

	var view = get_viewport()
	box.position = Vector2(
		(view.get_camera_2d().global_position.x - get_window().size.x) + randf_range(4 * view.size.x / 5, view.size.x),
		view.get_camera_2d().global_position.y - (get_window().size.y)
	)
	add_child(box)


func _on_player_area_2d_hit() -> void:
	PlayerStats.mapStats["health"] -= 1
	refresh($HUD/GUI/GameIcons/HeartCounter/Number, "health", PlayerStats.mapStats["health"])
	if PlayerStats.mapStats["health"] <= 0:
		get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")
