extends "res://subsystems/Subsystem.gd"

var extraSpeed = 0
var label = ""
var description = ""
var regenRate = 0.0 # per second
var type = "engine"

var health = 0

func _init(level):
	assert(level >= 1 && level <= 5)
	match level:
		1:
			label = "Steam"
			description = "It sure helps, but sending your crew to push the ship would work better than this."
			extraSpeed = 50.0
			image = "res://subsystems/icon-engine-1.png"

		2:
			label = "V12 Turbocharged"
			description = "If this sounds cool, you must be living in the 21st century. Obsolete technology, but there are worse thrusters around."
			extraSpeed = 110.0
			image = "res://subsystems/icon-engine-2.png"

		3:
			label = "Jet Engine"
			description = "A starfighter-class jet engine. Decent thrust, but keep an eye open for upgrades."
			extraSpeed = 195.0
			image = "res://subsystems/icon-engine-3.png"

		4:
			label = "Nuclear Fission"
			description = "Unleash the power of the atoms to fly faster. Wear a hazmat suit, just in case."
			extraSpeed = 275.0
			image = "res://subsystems/icon-engine-4.png"


		5:
			label = "Ionic Thrusters"
			description = "This sounds cool and it is cool! Best engine in the market!"
			extraSpeed = 350.0
			image = "res://subsystems/icon-engine-5.png"



func update(delta):
	.update(delta) # super
