@tool
extends Node2D

class_name Pattern

@export var cooldown: float = 1.0:
	set(new_cooldown):
		cooldown = new_cooldown
		timer.wait_time = cooldown
		if Engine.is_editor_hint() and is_processing():
			preview()
@export var mana_cost: int = 1
var timer: Timer = Timer.new()


var is_on_cooldown := false

func _init():
	timer.wait_time = cooldown
	##if not Engine.is_editor_hint():
		##add_child(timer)

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
	timer.start()
	await timer.timeout
	is_on_cooldown = false


## Preview function to visualise the pattern when updating variables
func preview():
	pass


func _on_tree_entered():
	if Engine.is_editor_hint():
		add_child(timer)
		timer.start()
		timer.timeout.connect(preview)
		preview()
	pass # Replace with function body.
