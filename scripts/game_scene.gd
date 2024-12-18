extends Node

const Card = preload("res://ressources/CardClass.gd")

@export var card_scene: PackedScene

var cards
var active_card

func refresh(node, key, value):
	PlayerStats.mapStats[key] = value
	node.text = str(value)

func _ready():
	cards = load_enemies("res://assets/Config/card.cfg")
	if cards.size() == 0:
		return
	spawn_ennemy_card(cards[0])
	randomize()
	refresh($HUD/GUI/GameIcons/HeartCounter/Number, "health", PlayerStats.mapStats["health"])
	refresh($HUD/GUI/GameIcons/MagicCounter/Number, "magic", PlayerStats.mapStats["magic"])
	refresh($HUD/GUI/GameIcons/MoneyCounter/Number, "money", PlayerStats.mapStats["money"])
	refresh($HUD/GUI/GameIcons/FameCounter/Number, "fame", PlayerStats.mapStats["fame"])
	refresh($HUD/GUI/GameIcons/StrengthCounter/Number, "strength", PlayerStats.mapStats["strength"])

func spawn_ennemy_card(card_info):
	# Create a new instance of the Mob scene.
	var card = card_scene.instantiate()

	card.setup_card(card_info)
	card.position = Vector2(get_window().size.x / 2, get_window().size.y / 2)
	card.connect("refuse", _on_card_refuse)
	card.connect("pakt", _on_card_pakt)
	active_card = card_info
	add_child(card)

func updateStats(effects: Array):
	for effect in effects:
		for key in effect.keys():
			match key:
				"health":
					refresh($HUD/GUI/GameIcons/HeartCounter/Number, "health", PlayerStats.mapStats["health"] + effect["health"])
				"magic":
					refresh($HUD/GUI/GameIcons/MagicCounter/Number, "magic", PlayerStats.mapStats["magic"] + effect["magic"])
				"money":
					refresh($HUD/GUI/GameIcons/MoneyCounter/Number, "money",  PlayerStats.mapStats["money"] + effect["money"])
				"fame":
					refresh($HUD/GUI/GameIcons/FameCounter/Number, "fame", PlayerStats.mapStats["fame"] + effect["fame"])
				"strength":
					refresh($HUD/GUI/GameIcons/StrengthCounter/Number, "strength", PlayerStats.mapStats["strength"] + effect["strength"])


func _on_card_pakt():
	$Audio.play()
	if cards.size() > 0:
		var card_to_remove_index = -1
		for i in range(cards.size()):
			if cards[i].title == active_card.title:
				card_to_remove_index = i
				break

		if card_to_remove_index != -1:
			cards.pop_at(card_to_remove_index)
			updateStats(active_card.pakt_effects)
	if cards.size() > 0:
		spawn_ennemy_card(cards[randi() % cards.size()])
	else:
		get_tree().change_scene_to_file("res://scenes/stair.tscn")

func _on_card_refuse():
	$Audio.play()
	if cards.size() > 0:
		var card_to_remove_index = -1
		for i in range(cards.size()):
			if cards[i].title == active_card.title:
				card_to_remove_index = i
				break

		if card_to_remove_index != -1:
			cards.pop_at(card_to_remove_index)
			updateStats(active_card.pass_effects)
	if cards.size() > 0:
		spawn_ennemy_card(cards[randi() % cards.size()])
	else:
		get_tree().change_scene_to_file("res://scenes/stair.tscn")

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
