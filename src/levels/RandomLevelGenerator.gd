extends Node2D

# Immutable generator properties
var level = 1
var length = TheConsts.BASE_LEVEL_LENGTH
var enemySpawnPeriod = TheConsts.BASE_ENEMY_SPAWN_PERIOD
var tollGenerated = false
var time = 0.0

var nextEnemyInSecs = 0



func _ready():
	nextEnemyInSecs = 0



func _process(delta):
	time += delta

	nextEnemyInSecs -= delta
	
	if nextEnemyInSecs > 0.0:
		return

	nextEnemyInSecs = enemySpawnPeriod

	var enemy = _getRandomEnemy()
	enemy.position = Vector2(1300, rand_range(20, 700))
	get_tree().current_scene.add_child(enemy)

	if !tollGenerated && time > length / 2:
		tollGenerated = true
		var toll = TheScenario.Toll.instance()
		toll.position.x = 1300
		get_tree().current_scene.add_child(toll)



func _getRandomEnemy():
	match randi() % 2:
		0: return TheEnemies.SmallAsteroid.instance()
		1: return TheEnemies.SmallSaucer.instance()
