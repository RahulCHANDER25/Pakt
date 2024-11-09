extends Node2D

const Card = preload("res://ressources/Card.gd")

var cards = [
	Card.new ("Heal", "Restore health", 10, preload("res://assets/Sprites/kirby.png")),
	Card.new("Attack", "Deal damage", 15, preload("res://assets/Sprites/kirby.png")),
	Card.new()
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$HUD.show_message("Uwu !")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
