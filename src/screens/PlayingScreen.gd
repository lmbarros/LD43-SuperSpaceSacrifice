extends Node2D


func _process(delta):
	if !ThePlayer.dead && Input.is_action_just_pressed("pause"):
		TheSound.select()
		$PauseMenu.initBeforeShow()
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



func _onBossDied():
	$BossDiedTimer.start()



func _onBossBecameActive(boss):
	if ThePlayer.dead:
		return

	if ThePlayer.level == TheConsts.TOTAL_LEVELS:
		_doEndGame()
		return

	TheSound.select()
	$BossMenu.initBeforeShow(boss)
	$BossMenu.show_modal(true)
	get_tree().paused = true
	Input.action_release("pause") # so that the pause menu itself doesn't unpause!



func _onBossDiedTimerTimeout():
	TheSound.stopMusic()
	ThePlayer.level += 1
	get_tree().change_scene("res://screens/NextLevelScreen.tscn")



func _doEndGame():
	if (ThePlayer.cargo1 && ThePlayer.cargo1.type == "item"
		|| ThePlayer.cargo2 && ThePlayer.cargo2.type == "item"
		|| ThePlayer.cargo3 && ThePlayer.cargo3.type == "item"
		|| ThePlayer.cargo4 && ThePlayer.cargo4.type == "item"):
		get_tree().change_scene("res://screens/VictoryScreen.tscn")
	else:
		get_tree().change_scene("res://screens/GameOverScreen.tscn")