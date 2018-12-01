extends "res://guns/BaseGun.gd"

func _init():
	model = "Cheap Laser"
	description = "Veteran space pilots say they used these to play cops and robbers when they were kids. Maybe some of them were not even joking."
	cooldown = 0.35
	bullet = TheBullets.SmallLaser
	icon = null # image representing the gun



func playSound():
	TheSound.smallLaser()
