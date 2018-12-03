extends "res://enemies/BaseEnemy.gd"


# When false, the boss is still making its entrance to scene.
var active = false
var label = ""

const shotInterval = 5.0

var timeToShot = shotInterval

onready var _gunL1 = TheGuns.Rockets.new()
onready var _gunL2 = TheGuns.Rockets.new()
onready var _gunL3 = TheGuns.Rockets.new()
onready var _gunR1 = TheGuns.Rockets.new()
onready var _gunR2 = TheGuns.Rockets.new()
onready var _gunR3 = TheGuns.Rockets.new()


func _ready():
	._ready()
	_gunL1.setFireAngleInDeg(180+20)
	_gunL2.setFireAngleInDeg(180)
	_gunL3.setFireAngleInDeg(180-20)
	_gunR1.setFireAngleInDeg(0+20)
	_gunR2.setFireAngleInDeg(0)
	_gunR3.setFireAngleInDeg(0-20)



func _process(delta):
	._process(delta)
	
	timeToShot -= delta

	# Get into the scene
	if !active && position.x > 1100:
		position.x -= TheConsts.STATIC_SPEED * delta

	if active:
		if timeToShot < 0.0:
			attack()
			timeToShot = shotInterval


func attack():
	_gunL1.fireEnemy(bulletsRoot, global_position)
	_gunL2.fireEnemy(bulletsRoot, global_position)
	_gunL3.fireEnemy(bulletsRoot, global_position)
	_gunR1.fireEnemy(bulletsRoot, global_position)
	_gunR2.fireEnemy(bulletsRoot, global_position)
	_gunR3.fireEnemy(bulletsRoot, global_position)
