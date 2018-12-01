extends KinematicBody2D

# Immutable projectile properties
var speed = 1000 # pixels/second
var damage = 1

var type = "projectile"

# PRojectile velocity, in pixels/second
var velocity = Vector2()


func init(pos, dir):
	position = pos
	velocity = dir * speed
	rotation = dir.angle()


func _process(delta):
	move_and_collide(velocity * delta)
	destroyIfOutOfBounds()



func _isOutOfBounds():
	return (position.x < -25 || position.x > 1300 ||
		position.y < -25 || position.y > 800)



func destroyIfOutOfBounds():
	if _isOutOfBounds():
		queue_free()
