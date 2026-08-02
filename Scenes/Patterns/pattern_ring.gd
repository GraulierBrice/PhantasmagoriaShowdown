@tool
extends PatternBullet


@export var bullet_count: int = 20:
	set(new_count):
		bullet_count = new_count
		if Engine.is_editor_hint() and can_preview:
			preview()
			

func execute(pattern_owner):
	var center = pattern_owner.global_position
	
	for i in range(bullet_count):
		var angle = (TAU / bullet_count) * i
		
		# Give velocity in direction
		var dir = Vector2(cos(angle), sin(angle))
		var bullet = spawn_bullet(dir)		
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
			var angle = (TAU / bullet_count) * i
			var dir = Vector2(cos(angle), sin(angle))

			var bullet = spawn_bullet(dir)
			add_child(bullet)
			bullet.owner =  get_tree().edited_scene_root

		timer.start()
	pass
