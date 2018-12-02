extends Control

# Go to the next screen?
var _canGo = false


func _ready():
	$NextLevel.text = "Level " + str(ThePlayer.level)


func _input(event):
	if _canGo && (event is InputEventJoypadButton || event is InputEventKey):
		Input.action_release("pause") # avoid starting paused
		get_tree().change_scene("res://screens/PlayingScreen.tscn")


func _onCanGoTimerTimeout():
	_canGo = true
