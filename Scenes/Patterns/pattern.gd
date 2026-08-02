@tool
extends Node2D

class_name Pattern

signal preview_done

## Exported Variables
@export var cooldown: float = 1.0:
	set(new_cooldown):
		cooldown = new_cooldown
		timer.wait_time = max(cooldown,0.1)
@export var mana_cost: int = 1

## Variables
var timer: Timer = Timer.new()
var is_on_cooldown := false
var can_preview: bool = false

func _init():
	timer.wait_time = cooldown
	if not Engine.is_editor_hint():
		add_child(timer)
		
func _ready():
	##if not Engine.is_editor_hint():
	##	execute(self)
	pass

func activate(pattern_owner):
	if is_on_cooldown:
		return
	
	execute(pattern_owner)
	start_cooldown()

func execute(pattern_owner):
	# Override in child classes
	pass

func start_cooldown():
	is_on_cooldown = true
	timer.start()
	await timer.timeout
	is_on_cooldown = false


## Preview function to visualise the pattern when updating variables
func preview():
	preview_done.emit()
	pass


func _on_tree_entered():
	can_preview = true
	if Engine.is_editor_hint():
		if not timer.get_parent():
			add_child(timer)
		if timer.get_parent() != self:
			timer.reparent(self)
		_on_preview_done()
	pass # Replace with function body.


func _on_preview_done():
	print(timer.wait_time)
	timer.stop()
	if not timer.get_parent():
		add_child(timer)
	if timer.get_parent() != self:
		timer.reparent(self)
	timer.start()
	await timer.timeout
	preview()
	pass # Replace with function body.
