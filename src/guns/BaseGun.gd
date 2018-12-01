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



func fire(scene, globalPos):
	if canFireInSecs > 0.0:
		return false
	
	canFireInSecs = cooldown

	var proj = bullet.instance()
	proj.init(globalPos, bulletVector)
	scene.add_child(proj)

	return true



func setFireAngleInRad(angle):
	bulletVector = polar2cartesian(1, angle)
