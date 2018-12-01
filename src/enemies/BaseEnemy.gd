extends Area2D


# Immutable enemy properties
var type = "enemy"
var shield = 0
var health = 1


func _onBodyEntered(body):
	if body.type == "bullet":
		hitByBullet(body)



func hitByBullet(bullet):
	health -= bullet.damage
	if health <= 0:
		die()
	bullet.queue_free()



func die():
	queue_free()
