@tool
extends PatternArc

@export_range(1,10,1) var swings: int = 1
var swings_counter: int = 0

func execute(pattern_owner):
	swings_counter = swings
	for i in range(swings):
		turn *= (-1 as Globals.ETurn)
		angle_offset = fmod(angle_offset+PI,TAU)
		await super.execute(pattern_owner)

func preview():
	swings_counter = swings
	for i in range(swings):
		turn *= (-1 as Globals.ETurn)
		angle_offset = fmod(angle_offset+PI,TAU)
		await super.preview()

func _on_preview_done():
	swings_counter -= 1
	if swings_counter <= 0:
		super._on_preview_done()
	
