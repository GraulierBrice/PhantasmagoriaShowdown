extends Node

@export var patterns: Array[PackedScene]

var equipped_patterns: Array = []

func _ready():
	# Instantiate first 3 patterns
	for i in range(min(3, patterns.size())):
		var p = patterns[i].instantiate()
		add_child(p)
		equipped_patterns.append(p)

func use_pattern(index: int, owner):
	if index < equipped_patterns.size():
		equipped_patterns[index].activate(owner)
