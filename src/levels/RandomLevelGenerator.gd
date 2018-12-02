extends Node2D

signal bossBecameActive(boss)
signal bossDied


# Immutable generator properties
var levelLength = TheConsts.BASE_LEVEL_LENGTH
var enemySpawnPeriod = TheConsts.BASE_ENEMY_SPAWN_PERIOD

var tollSpawned = false
var bossSpawned = false
var bossActivated = false
var boss = null # the boss himself
var bossWeakRef = null


var time = 0.0

var nextEnemyInSecs = 0



func _ready():
	nextEnemyInSecs = 0



func _process(delta):
	time += delta

	# Spawn enemies	
	if nextEnemyInSecs < 0.0 && time < levelLength:
		_spawnEnemy()
		nextEnemyInSecs = enemySpawnPeriod
	else:
		nextEnemyInSecs -= delta

	# Spawn the toll
	if !tollSpawned && time > levelLength / 2:
		tollSpawned = true
		var toll = TheScenario.Toll.instance()
		toll.position.x = 1300
		get_tree().current_scene.add_child(toll)
		
	# Spawn the boss
	if !bossSpawned && time > levelLength:
		_spawnBoss()

	# Activate the boss
	if boss && bossSpawned && !bossActivated && time > levelLength + 5.0:
		emit_signal("bossBecameActive", boss)
		boss.active = true
		bossActivated = true # need this because if the boss is dead we'll crash

	# Check if boss died
	if boss && bossWeakRef.get_ref() == null:
		emit_signal("bossDied")
		boss = null


func _spawnEnemy():
	var enemy = _getRandomEnemy()
	enemy.position = Vector2(1300, rand_range(20, 700))
	get_tree().current_scene.add_child(enemy)
	


func _getRandomEnemy():
	match randi() % 2:
		0: return TheEnemies.SmallAsteroid.instance()
		1: return TheEnemies.SmallSaucer.instance()



func _spawnBoss():
	boss = _getBoss()
	bossWeakRef = weakref(boss)
	bossSpawned = true
	boss.position = Vector2(1500, 360)
	get_tree().current_scene.add_child(boss)



func _getBoss():
	return TheEnemies.SaucerBoss.instance()
