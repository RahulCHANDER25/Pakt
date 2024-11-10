extends Camera2D

@export var target_path: NodePath
@onready var target = get_node(target_path)

func _process(delta):
	if target:
		global_position = target.global_position
