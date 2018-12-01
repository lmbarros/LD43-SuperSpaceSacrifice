extends Node2D



func _onPlayerDied():
	$PlayerDiedTimer.start()



func _onPlayerDiedTimerTimeout():
	var gameOverScreen = preload("res://screens/GameOverScreen.tscn")
	get_tree().change_scene_to(gameOverScreen)
