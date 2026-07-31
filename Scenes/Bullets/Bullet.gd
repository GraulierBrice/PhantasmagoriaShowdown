@tool
extends Area2D

class_name Bullet

@export var stats: Resource
var speed: float = 600.0
var damage: float = 1.0
var direction: Vector2 = Vector2.UP
var timeout: float = 15.0


var faction: Globals.EFaction

func _ready():
	if stats:
		speed = stats.speed
		damage = stats.damage

func _process(delta):
	if owner == get_tree().edited_scene_root:
		position -= speed * delta * direction
		
	# Delete if off-screen
	if not Engine.is_editor_hint():
		if global_position.y < -50 or global_position.y > 1000:
			queue_free()

func _on_body_entered(body):
	if not Engine.is_editor_hint():
		# Don't hit same faction
		if body.has_method("get_faction"):
			if body.get_faction() == faction:
				return
		
		if body.has_method("take_damage"):
			body.take_damage(damage)
			destroyed()


func _on_tree_entered():
	if not Engine.is_editor_hint():
		await get_tree().create_timer(timeout).timeout
		destroyed()
	pass # Replace with function body.

func destroyed():
	queue_free()
