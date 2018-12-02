extends Node2D


func _process(delta):
	if !ThePlayer.dead && Input.is_action_just_pressed("pause"):
		TheSound.select()
		$PauseMenu.show_modal(true)
		get_tree().paused = true
		Input.action_release("pause") # so that the pause menu itself doesn't unpause!
		


func _ready():
	TheSound.playInGameMusic()



func _onPlayerDied():
	$PlayerDiedTimer.start()



func _onPlayerDiedTimerTimeout():
	TheSound.stopMusic()
	get_tree().change_scene("res://screens/GameOverScreen.tscn")
