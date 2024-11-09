extends Node

func add_effect(effects: Array[Dictionary]) -> void:
	for effect in effects:
		for key in effect:
			var label = Label.new()
			label.text = "%s: %s" % [key, str(effect[key])]
			add_child(label)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
