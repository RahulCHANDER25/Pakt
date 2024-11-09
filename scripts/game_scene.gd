extends Node2D

const Card = preload("res://ressources/Card.gd")

var cards = [
	Card.new ("Heal", "Restore health", 10, preload("res://assets/Sprites/kirby.png")),
	Card.new("Attack", "Deal damage", 15, preload("res://assets/Sprites/kirby.png")),
	Card.new()
]
