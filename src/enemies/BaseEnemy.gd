extends Area2D


# Immutable enemy properties
var type = "enemy"
var shield = 0
var health = 1
var speed = 200 # in pixels/sec


func _process(delta):
	if _isOutOfBounds():
		queue_free()
	moveLeft(delta)



func _onBodyEntered(body):
	# Ignore whoever doesn't interact with the Enemies layer
	if body.collision_mask & 2 == 0:
		return

	if body.type == "bullet":
		hitByBullet(body)



func hitByBullet(bullet):
	health -= bullet.damage
	if health <= 0:
		die()
	bullet.queue_free()



func die():
	queue_free()



func _isOutOfBounds():
	return (position.x < -100 || position.x > 1500 ||
		position.y < -100 || position.y > 820)



func moveLeft(delta):
	position.x -= speed * delta
