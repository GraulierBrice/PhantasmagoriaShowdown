@tool
extends Bullet
class_name GuidedBullet

var turn_angle: float = 1.0 #Rotation in angle per second.
var target: Node2D

func _init(i_target: Node2D = null):
	target = i_target

func _ready():
	super._ready()
	if stats:
		turn_angle = stats.turn_angle
	if not Engine.is_editor_hint():
		target = SearchObjectByType.find_node_by_type(Heroine)
		print(target)
	else:
		target = get_parent()



func _process(delta):
	super._process(delta)
	if target:
		var target_direction = global_position - target.global_position 
		var angle_to_target = direction.angle_to(target_direction)
		direction = direction.rotated(angle_to_target/abs(angle_to_target) * turn_angle*delta)
