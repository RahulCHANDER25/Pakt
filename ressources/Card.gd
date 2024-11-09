extends Node2D

@export var title: String
@export var description: String
@export var positive_effect: int
@export var negative_effect: int
@export var texture: Texture2D

func _init(p_title: String = "", p_description: String = "", p_positive_effect: int = 0, p_negative_effect: int = 0, p_texture: Texture2D = null):
	title = p_title
	description = p_description
	positive_effect = p_positive_effect
	negative_effect = p_negative_effect
	texture = p_texture

func _ready():
	var sprite_node = Sprite2D.new()
	sprite_node.texture = texture
	add_child(sprite_node)
