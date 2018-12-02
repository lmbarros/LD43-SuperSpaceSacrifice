extends "res://bosses/BaseBoss.gd"


func _ready():
	crashDamage = 1.0e10 # Effectively instant kill
	shield = 10
	health = 30



func _process(delta):
	._process(delta)


func die():
	queue_free()
	TheSound.largeExplosion()
