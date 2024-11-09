extends Sprite2D

var dragging = false
var drag_start_position = Vector2.ZERO
var drag_threshold = 160

func _ready():
	$Area2D.input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_start_position = get_global_mouse_position()
			else:
				dragging = false
				_check_drag_direction()

func _process(delta):
	if dragging:
		position = get_global_mouse_position()

func _check_drag_direction():
	var drag_end_position = get_global_mouse_position()
	var drag_distance = drag_end_position.x - drag_start_position.x
	
	if abs(drag_distance) > drag_threshold:
		if drag_distance < 0:
			_on_drag_left()
		else:
			_on_drag_right()
	else:
		position = drag_start_position

func _on_drag_left():
	print("Dragged left")
	queue_free()

func _on_drag_right():
	print("Dragged right")
	queue_free()
