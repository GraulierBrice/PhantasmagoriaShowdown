extends CharacterBody2D

class_name Boss

@export var speed: float = 100.0
@export var max_health: float = 100.0
@onready var pattern_manager = $PatternManager

var faction: Globals.EFaction = Globals.EFaction.BOSS
var current_health: float

func _ready():
	current_health = max_health
	update_health_ui()

func _process(delta):
	handle_movement(delta)
	handle_patterns()

func handle_movement(delta):
	var input_dir = Vector2.ZERO
	
	# WASD controls for Player 2
	input_dir.x = Input.get_action_strength("boss_right") - Input.get_action_strength("boss_left")
	input_dir.y = Input.get_action_strength("boss_down") - Input.get_action_strength("boss_up")
	
	input_dir = input_dir.normalized()
	
	velocity = input_dir * speed
	move_and_slide()

func take_damage(amount: float):
	current_health -= amount
	current_health = max(current_health, 0)
	update_health_ui()
	
	
	if current_health <= 0:
		die()

func update_health_ui():
	if has_node("BossHealth"):
		$BossHealth.set_health(current_health / max_health)

func die():
	print("Boss defeated!")
	queue_free()

func get_faction():
	return faction

func handle_patterns():
	if Input.is_action_just_pressed("pattern_1"):
		pattern_manager.use_pattern(0, self)
	if Input.is_action_just_pressed("pattern_2"):
		pattern_manager.use_pattern(1, self)
	if Input.is_action_just_pressed("pattern_3"):
		pattern_manager.use_pattern(2, self)
