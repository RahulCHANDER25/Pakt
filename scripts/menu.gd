extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/stair.tscn")
func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options.tscn")
func _on_quit_game_pressed() -> void:
	get_tree().quit()
