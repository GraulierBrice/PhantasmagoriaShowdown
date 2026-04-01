extends CharacterBody2D

class_name Heroine

@export var speed: float = 300.0
@export var focus_speed: float = 150.0
@export var bullet_scene: PackedScene
@export var fire_rate: float = 0.03

var faction: Globals.EFaction = Globals.EFaction.HEROINE
var fire_timer := 0.0

func _process(delta):
	handle_movement(delta)
	handle_shooting(delta)

func handle_movement(delta):
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_dir = input_dir.normalized()
	
	var current_speed = speed
	
	# Focus mode (slow movement)
	if Input.is_action_pressed("focus"):
		current_speed = focus_speed
	
	velocity = input_dir * current_speed
	move_and_slide()

func handle_shooting(delta):
	fire_timer -= delta
	
	if Input.is_action_pressed("shoot") and fire_timer <= 0:
		fire()
		fire_timer = fire_rate

func get_faction():
	return faction

func fire():
	var bullet = bullet_scene.instantiate()
	
	# Spawn at marker
	var spawn_point = $BulletSpawn.global_position
	bullet.global_position = spawn_point
	bullet.faction = Globals.EFaction.HEROINE
	
	get_tree().current_scene.add_child(bullet)
	
func take_damage(amount: float):
	die()
	
func die():
	print("Heroine defeated!")
	queue_free()
