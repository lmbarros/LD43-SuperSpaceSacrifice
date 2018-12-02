extends Node

# Classes we'll use here
onready var Armor = preload("res://subsystems/Armor.gd")
onready var Shield = preload("res://subsystems/Shield.gd")
onready var Engine = preload("res://subsystems/Engine.gd")
onready var Lamb = preload("res://subsystems/Lamb.gd")


# This becomes true when hit without armor.
var dead = false

# Base speed, in pixels/second. Engines add speed on top of this.
const baseSpeed = 100

# Armor. If null, ship is not "wearing" armor.
var armor = null

# Shield. If null, ship is not "wearing" shield.
var shield = null

# Additional engine. If null, ship is using only the built-in engines.
var engine = null

# Bullets are added here
var bulletsRoot = null

# Player causes this amount of damage when crashing with enemies
var crashDamage = 20


# The guns
var gunForward1 = null
var gunForward2 = null
var gunBackward = null
var gunBombBay = null


# The cargo
var cargo1 = null
var cargo2 = null
var cargo3 = null
var cargo4 = null


# Crew size. Game over if zero.
var crew = 1


func init():
	dead = false

	armor = Armor.new(1)
	shield = Shield.new(2)
	engine = Engine.new(1)
	cargo1 = Lamb.new()

	gunForward1 = TheGuns.CheapLaser.new()
	gunForward1.manned = true
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
	_hitArmor(enemy.crashDamage)



func hitByBullet(bullet):
	TheSound.hit()
	var damage = bullet.damage

	if shield != null:
		damage = _hitShield(damage)

	_hitArmor(damage)



# Returns the amount of damage to surpass the shield
# Notice that shields are never destroyed; they always regen
func _hitShield(damage):
	if shield == null:
		return damage
	else:
		var remainingShield = shield.hit(damage)

		if remainingShield < 0:
			return -remainingShield

	return 0



func _hitArmor(damage):
	if damage == 0:
		return

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



func getSpeed():
	if engine == null:
		return baseSpeed
	else:
		return baseSpeed + engine.extraSpeed



func getUnassignedCrew():
	var un = crew

	if gunForward1 && gunForward1.manned: un -= 1
	if gunForward2 && gunForward2.manned: un -= 1
	if gunBackward && gunBackward.manned: un -= 1
	if gunBombBay && gunBombBay.manned: un -= 1

	if engine && engine.manned: un -= 1
	if armor && armor.manned: un -= 1
	if shield && shield.manned: un -= 1

	return un


func killCrew():
	if crew == 0:
		return
	
	if getUnassignedCrew() > 0:
		# Kill one of the unassigned ones
		crew -= 1
		return

	# Kill an assigned one; try the least useful first
	if gunBombBay && gunBombBay.manned: gunBombBay.manned = false
	elif gunBackward && gunBackward.manned: gunBackward.manned = false
	elif gunForward2 && gunForward2.manned: gunForward2.manned = false
	elif engine && engine.manned: engine.manned = false
	elif gunForward1 && gunForward1.manned: gunForward1.manned = false
	elif shield && shield.manned: shield.manned = false
	elif armor && armor.manned: armor.manned = false
