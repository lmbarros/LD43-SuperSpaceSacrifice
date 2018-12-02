extends Popup

func _process(delta):
	var isPaused = get_tree().paused
	$MoveAboveGame/BGFX.visible = isPaused
	$MoveAboveBGFX/Darken.visible = isPaused
	$MoveAboveEverything/UI.visible = isPaused

	if isPaused && Input.is_action_just_pressed("pause"):
		TheSound.select()
		hide()
		get_tree().paused = false
