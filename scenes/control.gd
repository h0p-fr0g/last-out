extends Control

@onready var line_edit = %LineEdit

func _ready():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.is_frozen = true
	
	line_edit.call_deferred("grab_focus")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		close_numpad()
	
	if event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()

func close_numpad():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.is_frozen = false
	queue_free()

func _on_line_edit_text_changed(new_text):
	var filtered = ""
	for c in new_text:
		if c in "0123456789":
			filtered += c
	
	if new_text != filtered:
		line_edit.text = filtered
		line_edit.caret_column = filtered.length()
