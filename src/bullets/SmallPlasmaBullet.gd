extends "res://bullets/BaseBullet.gd"



func init(pos, dir):
	speed = 500
	damage = 30
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



func _onAreaEntered(area):
	if area.collision_layer & (16 | 64) > 0: # Terrain / InstaKillers
		queue_free()
