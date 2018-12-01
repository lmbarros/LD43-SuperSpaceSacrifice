extends Area2D

# Immutable bullet properties
var speed = 1000 # pixels/second
var damage = 1

var type = "bullet"

# Bullet velocity, in pixels/second
var velocity = Vector2()


func init(pos, dir):
	position = pos
	velocity = dir * speed
	rotation = dir.angle()



func _process(delta):
	position += velocity * delta
	destroyIfOutOfBounds()



func _isOutOfBounds():
	return (position.x < -25 || position.x > 1300 ||
		position.y < -25 || position.y > 800)



func destroyIfOutOfBounds():
	if _isOutOfBounds():
		queue_free()
