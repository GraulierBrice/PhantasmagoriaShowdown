@tool
extends Bullet

class_name Laser

var damaging_targets: Array[Node2D] = []

func _on_body_entered(body):
	if not Engine.is_editor_hint():
		# Don't hit same faction
		if body.has_method("get_faction"):
			if body.get_faction() == faction:
				return
		
		if body.has_method("take_damage"):
			body.take_damage(damage)
			if not damaging_targets.has(body):
				damaging_targets.append(body)
				
func _process(delta):
	for target in damaging_targets:
		if target.has_method("take_damage"):
			target.take_damage(damage)
	rotation = direction.angle() + PI/2



func _on_body_exited(body):
	if damaging_targets.has(body):
		damaging_targets.erase(body)
	pass # Replace with function body.
