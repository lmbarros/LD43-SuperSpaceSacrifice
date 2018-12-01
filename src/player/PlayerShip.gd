extends Node2D

func _process(delta):
	doMovement(delta)

func doMovement(delta):
	var velocity = Vector2()

	if Input.is_action_pressed("right"):
			velocity.x += 1
	if Input.is_action_pressed("left"):
			velocity.x -= 1
	if Input.is_action_pressed("down"):
			velocity.y += 1
	if Input.is_action_pressed("up"):
			velocity.y -= 1

	if velocity.length() > 0:
			velocity = velocity.normalized() * ThePlayer.speed

	move_and_slide(velocity)
