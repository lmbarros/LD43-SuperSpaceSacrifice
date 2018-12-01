extends "res://enemies/BaseEnemy.gd"

var rot = 0
var angularSpeed = 0



func _ready():
	angularSpeed = rand_range(PI/3, PI)



func _process(delta):
	rotation += angularSpeed * delta

