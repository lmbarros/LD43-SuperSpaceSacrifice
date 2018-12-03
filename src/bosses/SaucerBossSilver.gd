extends "res://bosses/BaseBoss.gd"


func _ready():
	crashDamage = 1.0e10 # Effectively instant kill
	shield = 100
	health = 500
	label = "The Silver Saucer"



func _process(delta):
	._process(delta)



func die():
	queue_free()
	TheSound.largeExplosion()
