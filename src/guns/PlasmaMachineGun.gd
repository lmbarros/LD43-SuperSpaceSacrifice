extends "res://guns/BaseGun.gd"

func _init():
	label = "Plasma Machine Gun"
	description = "It's plasma and it's fast. What else coul you ask for?"
	cooldown = 0.2
	bullet = TheBullets.SmallPlasma
	image = "res://guns/icon-plasma-machine-gun.png"



func playSound():
	TheSound.mediumLaser()
