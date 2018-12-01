extends Node

# Player speed, in pixels/second
var speed = 0

# Health; game over if zero
var health = 0


# Bullets are added here
var bulletsRoot = null

# The guns
var gunForward1 = null
var gunForward2 = null
var gunBackward = null
var gunBombBay = null


func init():
	speed = 150
	health = 10
	
	gunForward1 = TheGuns.CheapLaser.new()
	gunForward1.setFireAngleInRad(0)

	gunForward2 = TheGuns.CheapLaser.new()
	gunForward2.setFireAngleInRad(-PI/4)

	gunBackward = TheGuns.CheapLaser.new()
	gunBackward.setFireAngleInRad(PI)

	gunBombBay = TheGuns.CheapLaser.new()
	gunBombBay.setFireAngleInRad(PI/2)



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
		gunForward1.fire(bulletsRoot, pos)



func fireForward2(pos):
	if gunForward2 != null:
		gunForward2.fire(bulletsRoot, pos)



func fireBackward(pos):
	if gunBackward != null:
		gunBackward.fire(bulletsRoot, pos)



func fireBombBay(pos):
	if gunBombBay != null:
		gunBombBay.fire(bulletsRoot, pos)



func crashedWithEnemy(damage):
	TheSound.crash()
	health -= damage
