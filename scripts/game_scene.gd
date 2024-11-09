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

var cards = [
	Card.new ("Crab", "Crabby crabby me",[{"health": 10}, {"magic": -3}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/kirby.png")),
	Card.new ("Hog", "Bad hogz spells", [{"magic" : 45} , {"health" : 2}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/hedgehog.png")),
	Card.new ("Crab", "Crabby crabby me",[{"health": 10}, {"magic": -3}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/kirby.png")),
	Card.new ("Hog", "Bad hogz spells", [{"magic" : 45} , {"health" : 2}], [{"health": 10}, {"magic": -3}],  preload("res://assets/Sprites/hedgehog.png")),
	Card.new ("Crab", "Crabby crabby me",[{"health": 10}, {"magic": -3}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/kirby.png")),
	Card.new ("Crab", "Crabby crabby me",[{"health": 10}, {"magic": -3}],  [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/kirby.png")),
	Card.new ("Hog", "Bad hogz spells", [{"magic" : 45} , {"health" : 2}],[{"health": 10}, {"magic": -3}],  preload("res://assets/Sprites/hedgehog.png")),
	Card.new ("Hog", "Bad hogz spells", [{"magic" : 45} , {"health" : 2}], [{"health": 10}, {"magic": -3}], preload("res://assets/Sprites/hedgehog.png")),
]

var active_card

func refresh(node, key, value):
	mapStats[key] = value
	node.text = str(value)

func _ready():
	spawn_ennemy_card(cards[0])
	randomize()
	refresh($HUD/GUI/GameIcons/HeartCounter/Number, "health", mapStats["health"])
	refresh($HUD/GUI/GameIcons/MagicCounter/Number, "magic", mapStats["magic"])
	refresh($HUD/GUI/GameIcons/MoneyCounter/Number, "money", mapStats["money"])
	refresh($HUD/GUI/GameIcons/FameCounter/Number, "fame", mapStats["fame"])
	refresh($HUD/GUI/GameIcons/StrengthCounter/Number, "strength", mapStats["strength"])

func spawn_ennemy_card(card):
	var new_card_instance = Card.new(card.title, card.description, card.pass_effects, card.pakt_effects, card.texture)
	var new_card_sprite = Sprite2D.new()
	new_card_sprite.texture = new_card_instance.texture
	
	new_card_sprite.position = Vector2(get_window().size.x / 2, get_window().size.y / 2)
	new_card_sprite.set_script(DraggableCard)
	new_card_sprite.connect("refuse", _on_card_refuse)
	new_card_sprite.connect("pakt", _on_card_pakt)

	var area = Area2D.new()
	area.name = "Area2D"
	var collision_shape = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	shape.extents = new_card_instance.texture.get_size() / 2
	collision_shape.shape = shape
	area.add_child(collision_shape)
	new_card_sprite.add_child(area)

	active_card = new_card_instance
	add_child(new_card_sprite)


func updateStats(effects: Array):
	for effect in effects:
		for key in effect.keys():
			match key:
				"health":
					refresh($HUD/GUI/GameIcons/HeartCounter/Number, "health", mapStats["health"] + effect["health"])
				"magic":
					refresh($HUD/GUI/GameIcons/MagicCounter/Number, "magic", mapStats["magic"] + effect["magic"])
				"money":
					refresh($HUD/GUI/GameIcons/MoneyCounter/Number, "money",  mapStats["money"] + effect["money"])
				"fame":
					refresh($HUD/GUI/GameIcons/FameCounter/Number, "fame", mapStats["fame"] + effect["fame"])
				"strength":
					refresh($HUD/GUI/GameIcons/StrengthCounter/Number, "strength", mapStats["strength"] + effect["strength"])



func _on_card_pakt():
	if cards.size() > 1:
		cards.pop_front()
		updateStats(active_card.pakt_effects)
		spawn_ennemy_card(cards[randi() % cards.size()])
		print(mapStats["health"])
		print(mapStats["magic"])
		print(mapStats["fame"])
	else:
		print("No more cards to spawn")

func _on_card_refuse():
	if cards.size() > 1:
		cards.pop_front()
		updateStats(active_card.pass_effects)
		spawn_ennemy_card(cards[randi() % cards.size()])
		print(mapStats["health"])
		print(mapStats["magic"])
		print(mapStats["fame"])
	else:
		print("No more cards to spawn")
