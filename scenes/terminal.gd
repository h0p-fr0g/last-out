extends Interactable

func _ready():
	super._ready()

func _input(event):
	if player_in_range and event.is_action_pressed("interact"):
		use_terminal()

func use_terminal():
	GlobalStats.current_ap -= 1
