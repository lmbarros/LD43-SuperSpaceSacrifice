extends "res://enemies/BaseEnemy.gd"

var deltaY = 100
onready var baseY = position.y
var time = 0
var oscillationMultiplier = 2.5

func _ready():
	time = rand_range(0, 2*PI)
	crashDamage = 20
	shield = 0
	health = 3
	speed = 100 # in pixels/sec



func _process(delta):
	time += delta
	if _isOutOfBounds():
		queue_free()
	moveLeft(delta)
	position.y = baseY + sin(time * oscillationMultiplier) * deltaY




func die():
	queue_free()
	TheSound.mediumExplosion()
