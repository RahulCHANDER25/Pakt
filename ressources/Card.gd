extends Node2D

class cardEffect:
	var stat: String
	var value: int
	
	func _init(s: String, i: int):
		stat = s
		value = i
		
@export var title: String
@export var description: String
var pass_effects: Array[Dictionary] = []
var pakt_effects: Array[Dictionary] = []
@export var texture: Texture2D


func _init(p_title: String = "", p_description: String = "", p_pass_effects: Array[Dictionary] = [], p_pakt_effects: Array[Dictionary] = [], p_texture: Texture2D = null):
	title = p_title
	description = p_description
	pass_effects = p_pass_effects
	pakt_effects = p_pakt_effects
	texture = p_texture

func _ready():
	var sprite_node = Sprite2D.new()
	sprite_node.texture = texture
	add_child(sprite_node)
