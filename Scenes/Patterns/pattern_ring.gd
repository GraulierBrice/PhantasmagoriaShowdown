extends Pattern


@export var bullet_scene: PackedScene
@export var bullet_count: int = 20
@export var bullet_speed: float = 200.0

func execute(owner):
	var center = owner.global_position
	
	for i in range(bullet_count):
		var angle = (TAU / bullet_count) * i
		
		var bullet = bullet_scene.instantiate()
		bullet.global_position = center
		
		# Give velocity in direction
		var dir = Vector2(cos(angle), sin(angle))
		bullet.direction = dir
		bullet.speed = bullet_speed
		bullet.faction = Globals.EFaction.BOSS
		
		get_tree().current_scene.add_child(bullet)
