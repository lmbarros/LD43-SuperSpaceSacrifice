extends Node2D

func _process(delta):
	position.x -= delta * TheConsts.STATIC_SPEED
	if position.x < -400:
		queue_free()



func _on_SacrificeWeaponAreaEntered(area):
	# TODO: Make this random...

	if ThePlayer.cargo4 && (ThePlayer.cargo4.type == "gun" || ThePlayer.cargo4.type == "bomb"):
		ThePlayer.cargo4 = null
		TheSound.select()
		return
	elif ThePlayer.cargo3 && (ThePlayer.cargo3.type == "gun" || ThePlayer.cargo3.type == "bomb"):
		ThePlayer.cargo3 = null
		TheSound.select()
		return
	elif ThePlayer.cargo2 && (ThePlayer.cargo2.type == "gun" || ThePlayer.cargo2.type == "bomb"):
		ThePlayer.cargo2 = null
		TheSound.select()
		return
	elif ThePlayer.cargo1 && (ThePlayer.cargo1.type == "gun" || ThePlayer.cargo1.type == "bomb"):
		ThePlayer.cargo1 = null
		TheSound.select()
		return
	elif ThePlayer.gunBackward:
		ThePlayer.gunBackward = null
		TheSound.select()
		return
	elif ThePlayer.gunBombBay:
		ThePlayer.gunBombBay = null
		TheSound.select()
		return
	elif ThePlayer.gunForward2:
		ThePlayer.gunForward2 = null
		TheSound.select()
		return
	elif ThePlayer.gunForward1:
		ThePlayer.gunForward1 = null
		TheSound.select()
		return

	# No money to pay the toll?! Death!
	ThePlayer.dead = true




func _onSacrificeSubsystemAreaEntered(area):
	# TODO: Make this random...

	if ThePlayer.cargo4 && (ThePlayer.cargo4.type == "engine" || ThePlayer.cargo4.type == "armor" || ThePlayer.cargo4.type == "shield"):
		ThePlayer.cargo4 = null
		TheSound.select()
		return
	elif ThePlayer.cargo3 && (ThePlayer.cargo3.type == "engine" || ThePlayer.cargo3.type == "armor" || ThePlayer.cargo3.type == "shield"):
		ThePlayer.cargo3 = null
		TheSound.select()
		return
	elif ThePlayer.cargo2 && (ThePlayer.cargo2.type == "engine" || ThePlayer.cargo2.type == "armor" || ThePlayer.cargo2.type == "shield"):
		ThePlayer.cargo2 = null
		TheSound.select()
		return
	elif ThePlayer.cargo1 && (ThePlayer.cargo1.type == "engine" || ThePlayer.cargo1.type == "armor" || ThePlayer.cargo1.type == "shield"):
		ThePlayer.cargo1 = null
		TheSound.select()
		return
	elif ThePlayer.engine:
		ThePlayer.engine = null
		TheSound.select()
		return
	elif ThePlayer.shield:
		ThePlayer.shield = null
		TheSound.select()
		return
	elif ThePlayer.armor:
		ThePlayer.armor = null
		TheSound.select()
		return

	# No money to pay the toll?! Death!
	ThePlayer.dead = true


func _onSacrificeCrewMemberAreaEntered(area):
	ThePlayer.killCrew()
	TheSound.select()
