extends Popup

signal yes
signal no

var _isShown = false

func _process(delta):
	if !_isShown:
		return

	if Input.is_action_just_pressed("yes"):
		TheSound.select()
		Input.action_release("pause")
		hide()
		get_tree().paused = false
		emit_signal("yes")
		return
	elif Input.is_action_just_pressed("no"):
		TheSound.select()
		Input.action_release("pause")
		hide()
		get_tree().paused = false
		emit_signal("no")
		return



func initBeforeShow(boss):
	_isShown = true
	$ColorRect/BossLabel.text = "Boss: " + boss.label

