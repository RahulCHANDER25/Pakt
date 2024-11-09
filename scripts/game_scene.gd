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

var cards

var active_card_sprite

func _ready():
	cards = load_enemies("res://assets/Config/card.cfg")
	if cards.size() == 0:
		return
	spawn_ennemy_card(cards[0])
	randomize()

func spawn_ennemy_card(card_info):
	# Create a new instance of the Mob scene.
	var card = card_scene.instantiate()

	card.setup_card(card_info)
	card.position = Vector2(get_window().size.x / 2, get_window().size.y / 2)
	card.connect("disappeared", _on_card_disappearance)

	$HUD/Description.text = card_info.description
	add_child(card)


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

func _on_card_disappearance():
	if cards.size() > 1:
		cards.pop_front()
		spawn_ennemy_card(cards[randi() % cards.size()])
	else:
		print("No more cards to spawn")
