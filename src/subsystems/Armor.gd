extends "res://subsystems/Subsystem.gd"

var maxHealth = 0
var label = ""
var description = ""

var health = 0


func update(delta):
	.update(delta) # call super



func _init(level):
	assert(level >= 1 && level <= 5)
	match level:
		1:
			label = "Level 1"
			description = "Calling this \"armor\" is on the verge of false advertising. Better than nothing, anyway."
			maxHealth = 30

		2:
			label = "Level 2"
			description = "Still better than level-1 armor, but some spaceball players wear more protection than this."
			maxHealth = 60

		3:
			label = "Level 3"
			description = "Decent protection. Bosses will laugh at you, anyway."
			maxHealth = 125

		4:
			label = "Level 4"
			description = "Good armor. Can't get much better than this."
			maxHealth = 250

		5:
			label = "Level 5"
			description = "The best armor in the universe. Well, not really, but this is the best you can use in your ship model."
			maxHealth = 500

	health = maxHealth



# Returns the remaining armor health. If zero or negative, means it was
# destroyed. If zero, it means it was just destroyed (no damage "surpassed" it).
func hit(damage):
	health -= damage
	return health
