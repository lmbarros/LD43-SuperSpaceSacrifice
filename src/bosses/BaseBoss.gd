extends "res://enemies/BaseEnemy.gd"


# When false, the boss is still making its entrance to scene.
var active = false

func _process(delta):
	._process(delta)

	# Get into the scene
	if !active && position.x > 1100:
		position.x -= TheConsts.STATIC_SPEED * delta
