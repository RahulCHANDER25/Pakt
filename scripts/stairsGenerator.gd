extends Node2D

@export var stair_scene: PackedScene
@export var paradise_scene: PackedScene
@export var stair_width = 65
@export var vertical_spacing = 50
var stair_counter = 0
var max_steps = 40
var win = false

var last_stair_position = Vector2.ZERO

func _ready():
	add_stair()

func _process(delta):
	while get_viewport().get_camera_2d().global_position.x > last_stair_position.x - 900 and win != true:
		add_stair()

func add_stair():
	stair_counter += 1
	print(stair_counter)
	if stair_counter == max_steps:
		win = true
		var paradise = paradise_scene.instantiate()
		add_child(paradise)
		paradise.position = last_stair_position
	
		var platform = paradise.get_node("Platform")
		var victory_label = paradise.get_node("VictoryLabel")
	
		if platform:
			platform.position = Vector2.ZERO
	
		if victory_label:
			victory_label.position = Vector2(0, -140)
			victory_label.text = "VICTORY      PARADISE TO THE RIGHT =>"
		return
	if stair_counter < max_steps:
		var new_stair = stair_scene.instantiate()
		add_child(new_stair)
		new_stair.position = last_stair_position

		last_stair_position.x += stair_width
		last_stair_position.y -= vertical_spacing
