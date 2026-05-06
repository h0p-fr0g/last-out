extends Label

func _process(_delta):
	var status_text = "AP: " + str(GlobalStats.current_ap)
	
	# Add Text for gun
	if GlobalStats.has_weapon:
		status_text += " [GUN]"
	
	text = status_text
