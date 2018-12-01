extends Object

# Immutable gun properties
var model = "Gun name"
var description = "Base class for all guns"
var cooldown = 0.2 # in seconds
var bullet = null # packed scene to instantiate
var icon = null # image representing the gun


# Cooldown control
var canFireInSecs = 0

# Normalized bullet vector
var bulletVector = Vector2()



func update(delta):
	canFireInSecs -= delta



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
