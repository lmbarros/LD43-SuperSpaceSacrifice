extends "res://enemies/BaseEnemy.gd"

var rot = 0
var angularSpeed = 0


func _ready():
	crashDamage = 7
	shield = 0
	health = 1
	speed = 200

	angularSpeed = rand_range(-PI, PI)



func _process(delta):
	._process(delta)  # call super
	position.x -= speed * delta
	rotation += angularSpeed * delta



func die():
	queue_free()
	TheSound.smallExplosion()
