extends "res://guns/BaseGun.gd"

func _init():
	label = "Quick Laser"
	description = "Weak, but shots quickly."
	cooldown = 0.12
	bullet = TheBullets.SmallLaser
	image = "res://guns/icon-quick-laser.png"



func playSound():
	TheSound.smallLaser()
