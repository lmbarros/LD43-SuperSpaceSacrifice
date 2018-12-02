extends Area2D

signal died


var type = "player"


func _ready():
	ThePlayer.bulletsRoot = get_tree().current_scene



func _process(delta):
	ThePlayer.updateSubsystems(delta)
	doMovement(delta)
	doFire()
	checkHealth()



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
		velocity = velocity.normalized() * ThePlayer.getSpeed()

	position += velocity * delta
	position.x = clamp(position.x, 35, 1235)
	position.y = clamp(position.y, 20, 700)



func doFire():
	if Input.is_action_pressed("fire_forward_1"):
		ThePlayer.fireForward1($GunSlots/Forward1.global_position)
	if Input.is_action_pressed("fire_forward_2"):
		ThePlayer.fireForward2($GunSlots/Forward2.global_position)
	if Input.is_action_pressed("fire_backward"):
		ThePlayer.fireBackward($GunSlots/Backward.global_position)
	if Input.is_action_pressed("fire_bomb_bay"):
		ThePlayer.fireBombBay($GunSlots/BombBay.global_position)



func checkHealth():
	if ThePlayer.dead:
		queue_free()
		TheSound.mediumExplosion()
		emit_signal("died")



func _onAreaEntered(area):
	# I think I need to do this manually for areas
	if collision_layer & area.collision_mask == 0:
		return

	match area.type:
		"enemy":
			ThePlayer.crashedWithEnemy(area)

		"bullet":
			ThePlayer.hitByBullet(area)
			area.queue_free()
