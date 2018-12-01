extends Node2D


var gunForward1 = null
var gunForward2 = null
var gunBackward = null
var gunBombBay = null



func _ready():
	gunForward1 = TheWeapons.CheapLaser.new()



func _process(delta):
	updateSubsystems(delta)
	doMovement(delta)
	doFire()



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



func doFire():
	var scene = get_tree().current_scene
	if Input.is_action_pressed("fire_forward_1") && gunForward1 != null:
		gunForward1.fire(scene, $GunSlots/Forward1.global_position, 0)



func updateSubsystems(delta):
	if gunForward1 != null:
		gunForward1.update(delta)
		
	if gunForward2 != null:
		gunForward2.update(delta)
		
	if gunBackward != null:
		gunBackward.update(delta)
		
	if gunBombBay != null:
		gunBombBay.update(delta)
