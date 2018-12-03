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
	if ThePlayer.level == 2:
		levelLength *= 1.2
		enemySpawnPeriod * 0.8
	elif ThePlayer.level == 3:
		levelLength *= 1.4
		enemySpawnPeriod * 0.6

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
	if ThePlayer.level == 1:
		var r = rand_range(0.0, 100.00)
		if r < 50: return TheEnemies.SmallAsteroid.instance()
		else: return TheEnemies.SmallSaucer.instance()
	elif ThePlayer.level == 2:
		var r = rand_range(0.0, 100.00)
		if r < 25: return TheEnemies.SmallAsteroid.instance()
		elif r < 75: return TheEnemies.SmallSaucer.instance()
		else: return TheEnemies.SmallSaucerSilver.instance()
	else:
		var r = rand_range(0.0, 100.00)
		if r < 10: return TheEnemies.SmallAsteroid.instance()
		elif r < 25: return TheEnemies.SmallSaucer.instance()
		elif r < 75: return TheEnemies.SmallSaucerSilver.instance()
		else: return TheEnemies.SmallSaucerGold.instance()



func _spawnBoss():
	boss = _getBoss()
	bossWeakRef = weakref(boss)
	bossSpawned = true
	boss.position = Vector2(1500, 360)
	get_tree().current_scene.add_child(boss)



func _getBoss():
	return TheEnemies.SaucerBoss.instance()


func _onBossMenuNo():
	pass # nothing, just fight!


func _onBossMenuYes():

	var sacrificed = false

	if ThePlayer.crew > 1:
		ThePlayer.killCrew()
		sacrificed = true
	elif ThePlayer.armor:
		ThePlayer.armor = null
		sacrificed = true
	elif ThePlayer.shield:
		ThePlayer.shield = null
		sacrificed = true
	elif ThePlayer.engine:
		ThePlayer.engine = null
		sacrificed = true
	elif ThePlayer.gunForward1:
		ThePlayer.gunForward1 = null
		sacrificed = true
	elif ThePlayer.gunForward2:
		ThePlayer.gunForward2 = null
		sacrificed = true
	elif ThePlayer.gunBombBay:
		ThePlayer.gunBombBay = null
		sacrificed = true
	elif ThePlayer.gunBackward:
		ThePlayer.gunBackward = null
		sacrificed = true
	elif ThePlayer.cargo1 && ThePlayer.cargo1.type != "item":
		ThePlayer.cargo1 = null
		sacrificed = true
	elif ThePlayer.cargo2 && ThePlayer.cargo2.type != "item":
		ThePlayer.cargo2 = null
		sacrificed = true
	elif ThePlayer.cargo3 && ThePlayer.cargo3.type != "item":
		ThePlayer.cargo3 = null
		sacrificed = true
	elif ThePlayer.cargo4 && ThePlayer.cargo4.type != "item":
		ThePlayer.cargo4 = null
		sacrificed = true

	if sacrificed:
		boss.queue_free()
	# else will have to fight
