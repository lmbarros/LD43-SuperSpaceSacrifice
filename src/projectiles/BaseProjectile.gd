extends KinematicBody2D

var speed = 1000 # pixels/second
var damage = 1

func _process(delta):
	var velocity = Vector2(speed, 0)
	move_and_collide(velocity * delta)
	destroyIfOutOfBounds()


func _isOutOfBounds():
	return (position.x < -25 || position.x > 1300 ||
		position.y < -25 || position.y > 800)


func destroyIfOutOfBounds():
	if _isOutOfBounds():
		queue_free()
