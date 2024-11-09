extends Node

const DraggableCard = preload("res://scripts/draggingCard.gd")
const Card = preload("res://ressources/Card.gd")

var cards = [
	Card.new ("Crab", "Crabby crabby me", 10, -2, preload("res://assets/Sprites/kirby.png")),
	Card.new ("Hog", "Bad hogz spells", 5, -3, preload("res://assets/Sprites/hedgehog.png")),
	Card.new ("Crab", "Crabby crabby me", 10, -2, preload("res://assets/Sprites/kirby.png")),
	Card.new ("Hog", "Bad hogz spells", 5, -3, preload("res://assets/Sprites/hedgehog.png")),
	Card.new ("Crab", "Crabby crabby me", 10, -2, preload("res://assets/Sprites/kirby.png")),
	Card.new ("Crab", "Crabby crabby me", 10, -2, preload("res://assets/Sprites/kirby.png")),
	Card.new ("Hog", "Bad hogz spells", 5, -3, preload("res://assets/Sprites/hedgehog.png")),
	Card.new ("Hog", "Bad hogz spells", 5, -3, preload("res://assets/Sprites/hedgehog.png")),
]

var active_card_sprite

func _ready():
	spawn_ennemy_card(cards[0])
	randomize()

func spawn_ennemy_card(card):
	var new_card_instance = Card.new(card.name, card.description, card.positive_effect, card.negative_effect, card.texture)
	var new_card_sprite = Sprite2D.new()
	new_card_sprite.texture = new_card_instance.texture
	
	new_card_sprite.position = Vector2(get_window().size.x / 2, get_window().size.y / 2)
	new_card_sprite.set_script(DraggableCard)
	new_card_sprite.connect("disappeared", Callable(self, "_on_card_disparition"))

	var area = Area2D.new()
	area.name = "Area2D"
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = new_card_sprite.texture.get_size() / 2
	collision_shape.shape = shape
	area.add_child(collision_shape)
	new_card_sprite.add_child(area)

	active_card_sprite = new_card_sprite
	add_child(new_card_sprite)

func _on_card_disparition():
	if cards.size() > 1:
		cards.pop_front()
		spawn_ennemy_card(cards[randi() % cards.size()])
	else:
		print("No more cards to spawn")
