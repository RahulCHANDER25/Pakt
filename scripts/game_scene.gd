extends Node

@export var card_scene: PackedScene

const Card = preload("res://ressources/CardClass.gd")

var cards = [
	Card.new ("Mage Stone", "Hello, I'm a stone mage. Do you want pakt with me ?", [{"health": 0}, {"mana": 0}], preload("res://assets/Sprites/divinity/1.png")),
	Card.new ("See Eyes", "...i give you some light...?", [{"health": 0}, {"mana": 0}], preload("res://assets/Sprites/divinity/2.png")),
	Card.new ("Thief", "Hurry ! Pakt or not ?", [{"health": 0}, {"mana": 0}], preload("res://assets/Sprites/divinity/3.png")),
	Card.new ("Muscle", "You envy me no ? pakt with me (of course) !", [{"health": 0}, {"mana": 0}], preload("res://assets/Sprites/divinity/4.png")),
	Card.new ("Rabbit", "Mushr.. Mushrm.. Mushrmm... pakt ?", [{"health": 0}, {"mana": 0}], preload("res://assets/Sprites/divinity/5.png"))
]

var active_card_sprite

func _ready():
	spawn_ennemy_card(cards[0])
	randomize()

func spawn_ennemy_card(card_info):
	# Create a new instance of the Mob scene.
	var card = card_scene.instantiate()
	
	card.setup_card(card_info)
	card.position = Vector2(get_window().size.x / 2, get_window().size.y / 2)
	card.connect("disappeared", Callable(self, "_on_card_disappeared"))
	add_child(card)

func _on_card_disappeared():
	if cards.size() > 1:
		cards.pop_front()
		spawn_ennemy_card(cards[randi() % cards.size()])
	else:
		print("No more cards to spawn")
