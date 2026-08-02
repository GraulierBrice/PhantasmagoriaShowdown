@tool
extends PatternArc

@export_range(1,10,1) var swings: int = 1

func preview():
	for i in range(swings):
		turn *= (-1 as Globals.ETurn)
		angle_offset = fmod(angle_offset+PI,TAU)
		super.preview()
