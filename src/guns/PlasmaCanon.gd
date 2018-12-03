extends "res://guns/BaseGun.gd"

func _init():
	label = "Plasma Cannon"
	description = "Very powerful. Quite slow."
	cooldown = 1.0
	bullet = TheBullets.LargePlasma
	image = "res://guns/icon-plasma-canon.png"



func playSound():
	TheSound.largeLaser()
