@tool
extends PatternBullet

class_name PatternArc

@export var bullet_count: int = 20:
	set(new_count):
		bullet_count = new_count
		if Engine.is_editor_hint() and can_preview:
			preview()

@export var angle_range: float = 180
@export var delay: float = 0.1
@export var turn:Globals.ETurn = Globals.ETurn.CLOCKWISE


func execute(pattern_owner):
	for i in range(bullet_count):
		var angle = (deg_to_rad(angle_range) / bullet_count) * i * turn
		
		# Give velocity in direction
		var dir = Vector2(cos(angle), sin(angle))
		var bullet = spawn_bullet(dir)
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
			var angle = (deg_to_rad(angle_range) / bullet_count) * i * turn
			var dir = Vector2(cos(angle), sin(angle))

			var bullet = spawn_bullet(dir)
			add_child(bullet)
			bullet.owner =  get_tree().edited_scene_root
			if delay > 0:
				await get_tree().create_timer(delay).timeout


		timer.start()
	pass
