extends "res://weapons/BaseWeapon.gd"

func _init():
	model = "Cheap Laser"
	description = "Veteran space pilots say they used these to play cops and robbers when they were kids. Maybe some of them were not even joking."
	cooldown = 0.35
	projectile = TheProjectiles.SmallLaser
	icon = null # image representing the weapon
