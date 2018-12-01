extends Area2D


# Immutable enemy properties
var type = "enemy"
var shield = 0
var health = 1


func _onBodyEntered(body):
	if body.type == "projectile":
		hitByProjectile(body)




func hitByProjectile(projectile):
	health -= projectile.damage
	if health <= 0:
		die()
	projectile.queue_free()



func die():
	queue_free()
