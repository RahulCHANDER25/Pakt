class_name Card
extends Node2D

class cardEffect:
	var stat: String
	var value: int
	
	func _init(s: String, i: int):
		stat = s
		value = i
		
@export var title: String
@export var description: String
var effects: Array[cardEffect] = []
@export var texture: Texture2D


func _init(p_title: String = "", p_description: String = "", p_effects = [{"health": 0}, {"mana": 0}], p_texture: Texture2D = null):
	title = p_title
	description = p_description
	texture = p_texture

func _ready():
	var sprite_node = Sprite2D.new()
	sprite_node.texture = texture
	add_child(sprite_node)
