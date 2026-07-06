extends Node2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var collision_shape = $StaticBody2D/CollisionShape2D
@onready var door_open_sound = $DoorOpenSound
@onready var light_occluder = $LightOccluder2D

func _ready() -> void:
	# 1. Wir zwingen die Tür beim Start, geschlossen zu sein
	anim_sprite.animation = "open"
	anim_sprite.frame = 0
	anim_sprite.stop()
	
	# 2. Physik und Licht für geschlossene Tür aktivieren
	collision_shape.set_deferred("disabled", false)
	light_occluder.visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Tür geht auf: Kollision und Schatten aus, Animation vorwärts abspielen
		collision_shape.set_deferred("disabled", true)
		light_occluder.visible = false
		
		if door_open_sound:
			door_open_sound.play()
			
		anim_sprite.play("open")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Tür geht zu: Kollision und Schatten wieder an, Animation rückwärts abspielen
		collision_shape.set_deferred("disabled", false)
		light_occluder.visible = true
		
		if door_open_sound:
			door_open_sound.play()
			
		# Das ist der Zauberbefehl: Er spielt die Animation wie ein Videoband rückwärts ab
		anim_sprite.play_backwards("open")
