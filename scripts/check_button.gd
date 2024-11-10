extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) 
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 
		DisplayServer.window_set_size(Vector2i(520, 820)) 
		

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
