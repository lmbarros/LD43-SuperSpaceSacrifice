extends Node

# Player speed, in pixels/second
var speed = 0

# Health; game over if zero
var health = 0

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
	speed = 150
	health = 10
	
	gunForward1 = TheGuns.CheapLaser.new()
	gunForward1.setFireAngleInDeg(0)

	gunForward2 = TheGuns.CheapLaser.new()
	gunForward2.setFireAngleInDeg(-45)

	gunBackward = TheGuns.CheapLaser.new()
	gunBackward.setFireAngleInDeg(180)

	gunBombBay = TheGuns.CheapLaser.new()
	gunBombBay.setFireAngleInDeg(90)



func updateSubsystems(delta):
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
	health -= enemy.crashDamage



func hitByBullet(bullet):
	TheSound.hit()
	health -= bullet.damage
