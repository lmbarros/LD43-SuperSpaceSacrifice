extends "res://subsystems/Subsystem.gd"

var maxHealth = 0.0
var label = ""
var description = ""
var regenRate = 0.0 # per second

var health = 0

func _init(level):
	assert(level >= 1 && level <= 5)
	match level:
		1:
			label = "Level 1"
			description = "This is basically a personal shield-generating belt glued to the hull."
			maxHealth = 30.0
			regenRate = 5.0

		2:
			label = "Level 2"
			description = "If one personal shield-generating belt glued to the hull is good, imagine two!"
			maxHealth = 60.0
			regenRate = 5.0

		3:
			label = "Level 3"
			description = "A shield normaly used in military jeeps or earth. Not bad."
			maxHealth = 125.0
			regenRate = 15.0

		4:
			label = "Level 4"
			description = "A starfighter-class shield. One of the best you can get."
			maxHealth = 250.0
			regenRate = 30.0

		5:
			label = "Level 5"
			description = "The ultimate starfighter-capable shield."
			maxHealth = 500.0
			regenRate = 50.0

	health = maxHealth



func update(delta):
	.update(delta) # super
	health += regenRate * delta
	print("r ", regenRate * delta)
	health = min(health, maxHealth)



# Returns the remaining shield health. If zero or negative, means it was
# destroyed. If zero, it means it was just destroyed (no damage "surpassed" it).
func hit(damage):
	health -= damage
	return health
