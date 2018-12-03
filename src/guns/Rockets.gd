extends "res://guns/BaseGun.gd"

func _init():
	label = "Rockets"
	description = "Unguided rockets. Ignore shields."
	cooldown = 0.5
	bullet = TheBullets.Rocket
	image = "res://guns/icon-rockets.png"



func playSound():
	TheSound.smallExplosion()
