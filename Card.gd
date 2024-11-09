class_name Card
extends Resource

@export var title: String
@export var description: String
@export var effect_value: int
@export var texture: Texture2D

func _init(p_title: String = "", p_description: String = "", p_effect_value: int = 0, p_texture: Texture2D = null):
	title = p_title
	description = p_description
	effect_value = p_effect_value
	texture = p_texture
