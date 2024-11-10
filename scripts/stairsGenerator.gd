extends Node2D

@export var stair_scene: PackedScene
@export var stair_width = 65
@export var vertical_spacing = 50

var last_stair_position = Vector2.ZERO

func _ready():
	add_stair()

func _process(delta):
	if get_viewport().get_camera_2d().global_position.x > last_stair_position.x - 900:
		add_stair()

func add_stair():
	var new_stair = stair_scene.instantiate()
	add_child(new_stair)
	new_stair.position = last_stair_position
	last_stair_position.x += stair_width
	last_stair_position.y -= vertical_spacing
