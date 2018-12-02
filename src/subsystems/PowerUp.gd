extends Area2D

var thing = null
var type = "powerup"

# Classes we'll use here
onready var Armor = preload("res://subsystems/Armor.gd")
onready var Shield = preload("res://subsystems/Shield.gd")
onready var Engine = preload("res://subsystems/Engine.gd")
onready var Lamb = preload("res://subsystems/Lamb.gd")


func _ready():
	var r = rand_range(0.0, 100.0)

	if r < 1.0: # Lamb
		thing = Lamb.new()
	elif r < 10.0: # A crew member!
		thing = "crew"
	elif r < 40.0: # Armor
		thing = Armor.new(1 + randi() % 5)
	elif r < 70.0: # Shield
		thing = Shield.new(1 + randi() % 5)
	else: #elif r < 90.0: # Engine
		thing = Engine.new(1 + randi() % 5)

	if typeof(thing) == TYPE_STRING:
		$Label.text = "Crew Member"
	else:
		$Label.text = thing.type.capitalize() + ": " + thing.label


func _process(delta):
	position.x -= delta * TheConsts.STATIC_SPEED
	if position.x < -200:
		queue_free()
