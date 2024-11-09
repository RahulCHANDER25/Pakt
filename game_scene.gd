extends Node2D

const Card = preload("res://Card.gd")

var cards = [
	Card.new ("Heal", "Restore health", 10, preload("res://kirby.png")),
	Card.new("Attack", "Deal damage", 15, preload("res://kirby.png")),
	Card.new()
]
