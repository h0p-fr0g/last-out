extends Interactable

@export var numpad_scene: PackedScene

func _input(event):
	if player_in_range and event.is_action_pressed("interact"):
		if GlobalStats.has_weapon:
			print("Already got gun.")
		else:
			open_numpad()

func open_numpad():
	var n = numpad_scene.instantiate()
	get_tree().root.add_child(n)
