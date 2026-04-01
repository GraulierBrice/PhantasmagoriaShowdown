extends Area2D

class_name Bullet

@export var speed: float = 600.0
@export var damage: float = 1.0
var direction: Vector2 = Vector2.UP

var faction: Globals.EFaction

func _process(delta):
	position -= speed * delta * direction
	
	# Delete if off-screen
	if position.y < -50 or position.y > 1000:
		queue_free()

func _on_body_entered(body):
	# Don't hit same faction
	if body.has_method("get_faction"):
		if body.get_faction() == faction:
			return
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
