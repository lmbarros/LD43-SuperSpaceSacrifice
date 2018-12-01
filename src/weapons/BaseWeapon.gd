extends Object

var model = "Weapon name"
var description = "Base class for all weapons"
var cooldown = 0.2 # in seconds
var projectile = null # packed scene to instantiate
var icon = null # image representing the weapon

var canFireInSecs = 0



func update(delta):
	canFireInSecs -= delta



func fire(scene, globalPos, rotation):
	if canFireInSecs > 0.0:
		return false
	
	canFireInSecs = cooldown

	var proj = projectile.instance()
	proj.position = globalPos
	proj.rotation = rotation
	scene.add_child(proj)

	return true
