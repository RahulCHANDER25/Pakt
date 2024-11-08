extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
		DisplayServer.window_set_size(Vector2i(520, 820)) 
		


func _on_rich_text_label_draw() -> void:
	pass # Replace with function body.
