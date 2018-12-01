extends Object

# Immutable weapon properties
var model = "Weapon name"
var description = "Base class for all weapons"
var cooldown = 0.2 # in seconds
var projectile = null # packed scene to instantiate
var icon = null # image representing the weapon


# Cooldown control
var canFireInSecs = 0

# Normalized projectile vector
var projectileVector = Vector2()



func update(delta):
	canFireInSecs -= delta



func fire(scene, globalPos):
	if canFireInSecs > 0.0:
		return false
	
	canFireInSecs = cooldown

	var proj = projectile.instance()
	proj.init(globalPos, projectileVector)
	scene.add_child(proj)

	return true



func setFireAngleInRad(angle):
	projectileVector = polar2cartesian(1, angle)
