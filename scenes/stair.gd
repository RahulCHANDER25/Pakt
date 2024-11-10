extends Node2D

#var statsPlayer = {
	#"health" : 10,
	#"magic" : 10,
	#"money" : 10,
	#"fame" : 10,
	#"strength" : 10,
#}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(PlayerStats.mapStats.health)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
