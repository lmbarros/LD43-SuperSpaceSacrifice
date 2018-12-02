extends Node2D

# Can go to the next screen?
var _canGo = false

func _onCanGoTimerTimeout():
	_canGo = true


func _input(event):
	if !_canGo:
		return
	
	if (event is InputEventJoypadButton || event is InputEventKey):
		ThePlayer.init()
		get_tree().change_scene("res://screens/PlayingScreen.tscn")
		Input.action_release("pause") # avoid starting paused
