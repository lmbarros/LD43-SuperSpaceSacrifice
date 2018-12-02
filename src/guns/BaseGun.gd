extends Object

# Immutable gun properties
var label = "Gun name"
var description = "Base class for all guns"
var cooldown = 0.2 # in seconds
var bullet = null # packed scene to instantiate
var image = "" # path to the icon representing the gun
var type = "gun"


# Cooldown control
var canFireInSecs = 0

# Normalized bullet vector
var bulletVector = Vector2()

# Is this gun manned?
var manned = false

func update(delta):
	var m = 1.5 if manned else 1.0
	canFireInSecs -= delta * m



func playSound():
	pass # override in subclasses, please



func firePlayer(scene, globalPos):
	_fire(scene, globalPos, true)



func fireEnemy(scene, globalPos):
	_fire(scene, globalPos, false)



func _fire(scene, globalPos, isPlayerShooting):
	# Enemies don't have to way for cooldown
	if isPlayerShooting && canFireInSecs > 0.0:
		return false

	playSound()
	canFireInSecs = cooldown

	var proj = bullet.instance()
	proj.init(globalPos, bulletVector)

	if isPlayerShooting:
		proj.collision_mask += 2 # Enemies
		proj.collision_layer = 4 # PlayerBullets
	else:
		proj.collision_mask += 1 # Player
		proj.collision_layer = 8 # EnemyBullets

	scene.add_child(proj)

	return true



func setFireAngleInDeg(angle):
	bulletVector = polar2cartesian(1, deg2rad(angle))
