extends Area2D


# Immutable enemy properties
var type = "enemy"
var crashDamage = 7 # how much damages player if crashes with it
var shield = 0
var health = 1
var speed = 200 # in pixels/sec



func _process(delta):
	if _isOutOfBounds():
		queue_free()
	checkHealth()


func _onAreaEntered(area):
	# I think I need to do this manually for areas
	if collision_layer & area.collision_mask == 0:
		return

	match area.type:
		"player":
			crashedWithThePlayer(area)

		"bullet":
			hitByBullet(area)
			area.queue_free()



func hitByBullet(bullet):
	TheSound.hit()
	health -= bullet.damage



func crashedWithThePlayer(player):
	health -= ThePlayer.crashDamage



func die():
	queue_free()



func _isOutOfBounds():
	return (position.x < -100 || position.x > 1500 ||
		position.y < -100 || position.y > 820)



func checkHealth():
	if health <= 0:
		die()
