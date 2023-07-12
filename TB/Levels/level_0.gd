extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	GridData.load_map(self)

func _input(event):
	if event.is_action_pressed("DEBUG"):
		pass
	elif event.is_action_pressed("DEBUG2"):
		GridData.debug_print_grid()
