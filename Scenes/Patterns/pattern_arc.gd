@tool
extends PatternBullet

class_name PatternArc

@export var bullet_count: int = 20:
	set(new_count):
		bullet_count = new_count
		if Engine.is_editor_hint() and can_preview:
			preview()

@export_range(0, 360, 0.1, "radians_as_degrees") var angle_range: float = 180
@export_range(0,5,0.01) var delay: float = 0.1
@export var turn:Globals.ETurn = Globals.ETurn.CLOCKWISE
@export_range(-180, 180, 0.1, "radians_as_degrees") var angle_offset: float = 0



func execute(pattern_owner):
	for i in range(bullet_count):
		var bullet = spawn_bullet(give_bullet_direction(i))
		if delay > 0:
			await get_tree().create_timer(delay).timeout
		add_child.call_deferred(bullet)

func preview():
	if owner == get_tree().edited_scene_root:
		##Remove all chilren
		
		for b in get_children():
			if b is Bullet:
				remove_child(b)
				b.queue_free()
		
		## Create bullets
		for i in range(bullet_count):
			var bullet = spawn_bullet(give_bullet_direction(i))
			add_child(bullet)
			bullet.owner =  get_tree().edited_scene_root
			if delay > 0:
				await get_tree().create_timer(delay).timeout

		timer.stop()
		timer.start()
	pass

func give_bullet_direction(slice: int) -> Vector2:
	var angle = (angle_range / bullet_count) * slice * turn + angle_offset
	var dir = Vector2(sin(angle), -cos(angle))
	return dir
	
