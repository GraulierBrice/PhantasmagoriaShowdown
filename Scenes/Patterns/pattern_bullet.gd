@tool
extends Pattern

class_name PatternBullet

@export var bullet_scene: PackedScene
@export var bullet_stats: Resource:
	set(new_stats):
		bullet_stats = new_stats
		if Engine.is_editor_hint() and can_preview:
			preview()

func execute(pattern_owner):
	self.add_child(spawn_bullet())

		
func preview():
	if owner == get_tree().edited_scene_root:
		## Create bullet
		var bullet = spawn_bullet()
		add_child(bullet)
		bullet.owner = get_tree().edited_scene_root
		preview_done.emit()

func _on_preview_done():
	timer.start()
	await timer.timeout
	clear_child_bullets()
	preview()
	pass 

	

##Creates a bullet to spawn
func spawn_bullet(dir: Vector2 = Vector2.UP, pos:Vector2=global_position)->Bullet:
	var bullet = bullet_scene.instantiate()
	
	bullet.direction = dir
	bullet.stats = bullet_stats
	#TODO: Check owner faction. Might use this system for players.
	bullet.faction = Globals.EFaction.BOSS
	return bullet

func clear_child_bullets():
	for b in get_children():
		if b is Bullet:
			remove_child(b)
			b.queue_free()
	
