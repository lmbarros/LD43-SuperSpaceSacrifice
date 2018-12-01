extends Node2D


func _ready():
	TheSound.playInGameMusic()



func _onPlayerDied():
	$PlayerDiedTimer.start()



func _onPlayerDiedTimerTimeout():
	TheSound.stopMusic()
	get_tree().change_scene("res://screens/GameOverScreen.tscn")
