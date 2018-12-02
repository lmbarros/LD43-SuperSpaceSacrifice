extends CanvasLayer


var _maxHeight = 200


func _process(delta):
	_rescaleBars()
	$ArmorBar.value = ThePlayer.getArmor()
	$ShieldBar.value = ThePlayer.getShield()
	$LevelLabel.text = "Level " + str(ThePlayer.level) + " / " + str(TheConsts.TOTAL_LEVELS)


func _rescaleBars():
	var maxArmorEver = 500
	var maxArmor = max(1, ThePlayer.getMaxArmor())
	var maxArmorHeight = max(3, _maxHeight * (maxArmor / float(maxArmorEver)))
	$ArmorBar.max_value = maxArmor
	$ArmorBar.rect_size.y = maxArmorHeight
	$ArmorBar.rect_position.y = 720 - maxArmorHeight - 23

	var maxShieldEver = 500
	var maxShield = max(1, ThePlayer.getMaxShield())
	var maxShieldHeight = max(3, _maxHeight * (maxShield / float(maxShieldEver)))
	$ShieldBar.max_value = maxShield
	$ShieldBar.rect_size.y = maxShieldHeight
	$ShieldBar.rect_position.y = 720 - maxShieldHeight - 23
