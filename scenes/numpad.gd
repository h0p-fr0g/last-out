extends Control

@onready var line_edit: LineEdit = $LineEdit

# Hier kannst du den richtigen Code festlegen
var correct_code: String = "1234" 

func _ready():
	line_edit.call_deferred("grab_focus")
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.is_frozen = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		close_numpad()
	
	# Wenn Enter gedrückt wird (ui_accept ist standardmäßig Enter/Space)
	if event.is_action_pressed("ui_accept"):
		validate_input()
		get_viewport().set_input_as_handled()

	if event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()

func _on_line_edit_text_changed(new_text: String) -> void:
	var filtered = ""
	for c in new_text:
		if c in "0123456789":
			filtered += c
	
	# Limit auf 4 Ziffern
	if filtered.length() > 4:
		filtered = filtered.substr(0, 4)
	
	if new_text != filtered:
		line_edit.text = filtered
		line_edit.caret_column = filtered.length()

func validate_input():
	var input = line_edit.text
	
	# 2. Code prüfen
	if input == correct_code:
		print("CODE CORRECT!")
		GlobalStats.has_weapon = true
		GlobalStats.current_ap -= 1
		close_numpad()
	else:
		print("WRONG CODE!")
		GlobalStats.current_ap -= 1
		line_edit.text = ""
		close_numpad()

func close_numpad():
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.is_frozen = false
	queue_free()
