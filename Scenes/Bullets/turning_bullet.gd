@tool
extends Bullet
class_name TurningBullet

var turn_angle: float = 1.0 #Rotation in angle per second.

func _ready():
	super._ready()
	if stats:
		turn_angle = stats.turn_angle


func _process(delta):
	super._process(delta)
	turn(delta)
	
func turn(delta):
	direction = direction.rotated(turn_angle*delta)
