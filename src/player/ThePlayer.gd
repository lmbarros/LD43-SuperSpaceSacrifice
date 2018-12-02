extends Node

# Classes we'll use here
onready var Armor = preload("res://subsystems/Armor.gd")
onready var Shield = preload("res://subsystems/Shield.gd")

# This becomes true when hit without armor.
var dead = false

# Player speed, in pixels/second
var speed = 0

# Armor. If null, ship is not "wearing" armor.
var armor = null

# Shield. If null, ship is not "wearing" shield.
var shield = null

# Bullets are added here
var bulletsRoot = null

# Player causes this amount of damage when crashing with enemies
var crashDamage = 20


# The guns
var gunForward1 = null
var gunForward2 = null
var gunBackward = null
var gunBombBay = null


func init():
	dead = false
	speed = 150

	armor = Armor.new(1)
	shield = Shield.new(2)

	gunForward1 = TheGuns.CheapLaser.new()
	gunForward1.setFireAngleInDeg(0)

	gunForward2 = TheGuns.CheapLaser.new()
	gunForward2.setFireAngleInDeg(-45)

	gunBackward = TheGuns.CheapLaser.new()
	gunBackward.setFireAngleInDeg(180)

	gunBombBay = TheGuns.CheapLaser.new()
	gunBombBay.setFireAngleInDeg(90)



func updateSubsystems(delta):
	if armor != null:
		armor.update(delta)
	
	if shield != null:
		shield.update(delta)

	if gunForward1 != null:
		gunForward1.update(delta)
		
	if gunForward2 != null:
		gunForward2.update(delta)
		
	if gunBackward != null:
		gunBackward.update(delta)
		
	if gunBombBay != null:
		gunBombBay.update(delta)



func fireForward1(pos):
	if gunForward1 != null:
		gunForward1.firePlayer(bulletsRoot, pos)



func fireForward2(pos):
	if gunForward2 != null:
		gunForward2.firePlayer(bulletsRoot, pos)



func fireBackward(pos):
	if gunBackward != null:
		gunBackward.firePlayer(bulletsRoot, pos)



func fireBombBay(pos):
	if gunBombBay != null:
		gunBombBay.firePlayer(bulletsRoot, pos)



func crashedWithEnemy(enemy):
	TheSound.crash()
	_hit(enemy.crashDamage)



func hitByBullet(bullet):
	TheSound.hit()
	_hit(bullet.damage)



func _hit(damage):
	if armor == null:
		dead = true
	else:
		var remainingArmor = armor.hit(damage)
		if remainingArmor <= 0:
			armor = null
			if remainingArmor < 0:
				dead = true



func getArmor():
	if armor == null:
		return 0
	else:
		return armor.health



func getMaxArmor():
	if armor == null:
		return 0
	else:
		return armor.maxHealth



func getShield():
	if shield == null:
		return 0
	else:
		return shield.health



func getMaxShield():
	if shield == null:
		return 0
	else:
		return shield.maxHealth
