extends Area2D
class_name Interactable

var player_in_range = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		if body.has_method("set_interaction_hint"):
			body.set_interaction_hint(true)

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		if body.has_method("set_interaction_hint"):
			body.set_interaction_hint(false)
