extends Area2D

signal refuse
signal pakt

var dragging = false
var drag_start_position = Vector2.ZERO
var drag_threshold = 160
var can_drag = false
var max_rotation = 20
var original_scale: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(0.5)
	timer.connect("timeout", _on_drag_delay_timeout)
	add_child(timer)
	timer.start()
	original_scale = scale
	call_deferred("_setup_area2d")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dragging:
		var mouse_position = get_global_mouse_position()
		position = mouse_position
		var drag_distance = mouse_position.x - drag_start_position.x
		var drag_percentage = clamp(abs(drag_distance / drag_threshold), 0, 1)
		var rotation_amount = max_rotation * drag_percentage * sign(drag_distance)
		var scale_amount = 1 - drag_percentage
		if scale_amount < 0.5:
			scale_amount = 0.5
		rotation_degrees = rotation_amount
		scale = Vector2(scale_amount, scale_amount)

func setup_card(card_info) -> void:
	$TextureRect.texture = card_info.texture
	$Title.text = card_info.title
	$Description.text = card_info.description
	$PassEffect.add_effect(card_info.pass_effects)
	$PaktEffect.add_effect(card_info.pakt_effects)


func _on_drag_delay_timeout():
	can_drag = true

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				drag_start_position = get_global_mouse_position()
			else:
				dragging = false
				_check_drag_direction()

func _check_drag_direction():
	var drag_end_position = get_global_mouse_position()
	var drag_distance = drag_end_position.x - drag_start_position.x

	if abs(drag_distance) > drag_threshold:
		if drag_distance < 0:
			_on_drag_left()
		else:
			_on_drag_right()
	else:
		position = Vector2(get_window().size.x / 2, get_window().size.y / 2)
		rotation_degrees = 0
		scale = original_scale

func _on_drag_left():
	print("Dragged left")
	emit_signal("refuse")
	queue_free()


func _on_drag_right():
	print("Dragged right")
	emit_signal("pakt")
	queue_free()


func _on_card_disappeared() -> void:
	pass # Replace with function body.
