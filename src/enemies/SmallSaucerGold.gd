extends "res://enemies/BaseEnemy.gd"

var deltaY = 100
onready var baseY = position.y
var time = 0
var oscillationMultiplier = 2.5

var attackCooldown = 0.8

onready var shootInSecs = rand_range(attackCooldown/2, attackCooldown)

onready var _gunL1 = TheGuns.PlasmaCanon.new()
onready var _gunL2 = TheGuns.Rockets.new()
onready var _gunL3 = TheGuns.PlasmaCanon.new()
onready var _gunR1 = TheGuns.PlasmaMachineGun.new()
onready var _gunR2 = TheGuns.Rockets.new()
onready var _gunR3 = TheGuns.PlasmaMachineGun.new()



func _ready():
	time = rand_range(0, 2*PI)
	crashDamage = 100
	shield = 20
	health = 25
	speed = 250 # in pixels/sec

	_gunL1.setFireAngleInDeg(180+20)
	_gunL2.setFireAngleInDeg(180)
	_gunL3.setFireAngleInDeg(180-20)
	_gunR1.setFireAngleInDeg(0+20)
	_gunR2.setFireAngleInDeg(0)
	_gunR3.setFireAngleInDeg(0-20)



func _process(delta):
	._process(delta) # call super

	time += delta

	position.x -= speed * delta
	position.y = baseY + sin(time * oscillationMultiplier) * deltaY

	shootInSecs -= delta

	if shootInSecs <= 0:
		shootInSecs = attackCooldown
		attack()



func die():
	queue_free()
	TheSound.mediumExplosion()
	spawnPowerUpMaybe(0.25)



func attack():
	_gunL1.fireEnemy(bulletsRoot, $Guns/GunL.global_position)
	_gunL2.fireEnemy(bulletsRoot, $Guns/GunL.global_position)
	_gunL3.fireEnemy(bulletsRoot, $Guns/GunL.global_position)
	_gunR1.fireEnemy(bulletsRoot, $Guns/GunR.global_position)
	_gunR2.fireEnemy(bulletsRoot, $Guns/GunR.global_position)
	_gunR3.fireEnemy(bulletsRoot, $Guns/GunR.global_position)
