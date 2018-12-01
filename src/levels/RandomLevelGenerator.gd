extends Node2D

# Immutable generator properties
var level = 1
var length = 60 # in seconds, until the boss
var enemySpawnPeriod = 4 # an enemy is spawned every this many seconds


var nextEnemyInSecs = 0



func _ready():
	nextEnemyInSecs = 0



func _process(delta):
	nextEnemyInSecs -= delta
	
	if nextEnemyInSecs > 0.0:
		return

	nextEnemyInSecs = enemySpawnPeriod

	var enemy = TheEnemies.SmallAsteroid.instance()
	get_tree().current_scene.add_child(enemy)
	enemy.position = Vector2(1300, rand_range(20, 700))
