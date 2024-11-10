extends Camera2D

@export var target_path: NodePath
@onready var target = get_node(target_path)

var max_x

func _ready() -> void:
	max_x = global_position.x

func _process(delta):
	if target:
		if (target.global_position.x > global_position.x):
			global_position.x = target.global_position.x
		global_position.y = target.global_position.y
