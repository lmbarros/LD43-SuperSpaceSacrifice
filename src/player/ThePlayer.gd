extends Node

# Player speed, in pixels/second
var speed = 150

# Projectiles are added here
var projectilesRoot = null

# The guns
var gunForward1 = null
var gunForward2 = null
var gunBackward = null
var gunBombBay = null



func _ready():
	gunForward1 = TheWeapons.CheapLaser.new()
	gunForward1.setFireAngleInRad(0)

	gunForward2 = TheWeapons.CheapLaser.new()
	gunForward2.setFireAngleInRad(-PI/4)

	gunBackward = TheWeapons.CheapLaser.new()
	gunBackward.setFireAngleInRad(PI)

	gunBombBay = TheWeapons.CheapLaser.new()
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
		gunForward1.fire(projectilesRoot, pos)



func fireForward2(pos):
	if gunForward2 != null:
		gunForward2.fire(projectilesRoot, pos)



func fireBackward(pos):
	if gunBackward != null:
		gunBackward.fire(projectilesRoot, pos)



func fireBombBay(pos):
	if gunBombBay != null:
		gunBombBay.fire(projectilesRoot, pos)
