extends Node2D



func _onPlayerDied():
	$PlayerDiedTimer.start()



func _onPlayerDiedTimerTimeout():
	get_tree().change_scene("res://screens/GameOverScreen.tscn")
