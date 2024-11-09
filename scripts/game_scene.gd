extends Node

const Card = preload("res://ressources/CardClass.gd")

@export var card_scene: PackedScene

var mapStats = {
	"health" : 10,
	"magic" : 10,
	"money" : 10,
	"fame" : 10,
	"strength" : 10,
}

var cards = [
	Card.new ("Mage Stone", "Hello, I'm a stone mage. Do you want pakt with me ?", [{"health": 10}, {"magic": -3}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/divinity/1.png")),
	Card.new ("See Eyes", "...i give you some light...?", [{"health": 10}, {"magic": -3}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/divinity/2.png")),
	Card.new ("Thief", "Hurry ! Pakt or not ?", [{"health": 10}, {"magic": -3}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/divinity/3.png")),
	Card.new ("Muscle", "You envy me no ? pakt with me (of course) !", [{"health": 10}, {"magic": -3}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/divinity/4.png")),
	Card.new ("Rabbit", "Mushr.. Mushrm.. Mushrmm... pakt ?", [{"health": 10}, {"magic": -3}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/divinity/5.png"))
]

var active_card_sprite

func _ready():
	cards.assign(load_enemies("res://assets/Config/card.cfg"))
	if cards.size() == 0:
		return
	spawn_ennemy_card(cards[0])
	randomize()

func spawn_ennemy_card(card_info):
	# Create a new instance of the Mob scene.
	var card = card_scene.instantiate()

	card.setup_card(card_info)
	card.position = Vector2(get_window().size.x / 2, get_window().size.y / 2)
	card.connect("disappeared", Callable(self, "_on_card_disappeared"))
	add_child(card)

	# $HUD/Description.text = new_card_instance.description
	# active_card = new_card_instance
	# add_child(new_card_sprite)

func load_enemies(path: String):
	var config = ConfigFile.new()

	var err = config.load(path)
	if err != OK:
		return []
	var allCards = []
	for card in config.get_sections():
		var new_card = Card.new(
			config.get_value(card, "title"),
			config.get_value(card, "description"),
		)
		new_card.pass_effects.assign(config.get_value(card, "pass_effects"))
		new_card.pakt_effects.assign(config.get_value(card, "pakt_effects"))
		
		new_card.texture = load(config.get_value(card, "texture"))
		
		allCards.push_back(new_card)
	return allCards

func _on_card_disparition():
	if cards.size() > 1:
		cards.pop_front()
		spawn_ennemy_card(cards[randi() % cards.size()])
	else:
		print("No more cards to spawn")
