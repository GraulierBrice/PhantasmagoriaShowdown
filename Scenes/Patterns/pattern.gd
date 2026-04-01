extends Node2D

class_name Pattern

@export var cooldown: float = 1.0
@export var mana_cost: int = 1


var is_on_cooldown := false

func activate(owner):
	if is_on_cooldown:
		return
	
	execute(owner)
	start_cooldown()

func execute(owner):
	# Override in child classes
	pass

func start_cooldown():
	is_on_cooldown = true
	await get_tree().create_timer(cooldown).timeout
	is_on_cooldown = false
