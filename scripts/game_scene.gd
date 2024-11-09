extends Node

const DraggableCard = preload("res://scripts/draggingCard.gd")
const Card = preload("res://ressources/Card.gd")

var mapStats = {
	"health" : 10,
	"magic" : 10,
	"money" : 10,
	"fame" : 10,
	"strength" : 10,
}

var mapStatsNodes = {
	"health" : $HUD/GUI/GameIcons/HeartCounter/Number,
	"magic" : $HUD/GUI/GameIcons/MagicCounter/Number,
	"money" : $HUD/GUI/GameIcons/MoneyCounter/Number,
	"fame" : $HUD/GUI/GameIcons/FameCounter/Number,
	"strength" : $HUD/GUI/GameIcons/StrengthCounter/Number,
}

var cards

var active_card

func _ready():
	cards = load_enemies("res://assets/Config/card.cfg")
	if cards.size() == 0:
		return
	spawn_ennemy_card(cards[0])
	randomize()

func spawn_ennemy_card(card):
	var new_card_instance = Card.new(card.title, card.description, card.pass_effects, card.pakt_effects, card.texture)
	var new_card_sprite = Sprite2D.new()
	new_card_sprite.texture = new_card_instance.texture
	
	new_card_sprite.position = Vector2(get_window().size.x / 2, get_window().size.y / 2)
	new_card_sprite.set_script(DraggableCard)
	new_card_sprite.connect("disappeared", _on_card_disparition)

	var area = Area2D.new()
	area.name = "Area2D"
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = new_card_instance.texture.get_size() / 2
	collision_shape.shape = shape
	area.add_child(collision_shape)
	new_card_sprite.add_child(area)

	$HUD/Description.text = new_card_instance.description
	active_card = new_card_instance
	add_child(new_card_sprite)

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
		if active_card.pass_effects[0].has("health"):
			print(active_card.pass_effects[0]["health"])
		spawn_ennemy_card(cards[randi() % cards.size()])
	else:
		print("No more cards to spawn")
