@tool
extends Pattern


@export var bullet_scene: PackedScene
@export var bullet_count: int = 20:
	set(new_count):
		bullet_count = new_count
		if Engine.is_editor_hint():
			preview()
			
@export var bullet_stats: Resource:
	set(new_stats):
		bullet_stats = new_stats
		if Engine.is_editor_hint():
			preview()

func _ready():
	if not Engine.is_editor_hint():
		execute(self)

func execute(owner):
	var center = owner.global_position
	
	for i in range(bullet_count):
		var angle = (TAU / bullet_count) * i
		
		var bullet = bullet_scene.instantiate()
		bullet.global_position = center
		
		# Give velocity in direction
		var dir = Vector2(cos(angle), sin(angle))
		bullet.direction = dir
		bullet.stats = bullet_stats
		bullet.faction = Globals.EFaction.BOSS
		
		get_tree().current_scene.add_child(bullet)

		
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
			
			var bullet = bullet_scene.instantiate()
			var dir = Vector2(cos(angle), sin(angle))
			bullet.direction = dir
			bullet.stats = bullet_stats
			bullet.faction = Globals.EFaction.BOSS
			add_child(bullet)
			bullet.owner =  get_tree().edited_scene_root

		timer.start()
	pass
