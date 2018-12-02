extends Popup

var _isWeaponsSelected = false
var _isSubsystemsSelected = false
var _isCargoSelected = false

# Indices; first valid index is 1
var _weaponSelected = 0
var _subsystemSelected = 0
var _cargoSelected = 0



func _process(delta):
	var isPaused = get_tree().paused
	$MoveAboveGame/BGFX.visible = isPaused
	$MoveAboveBGFX/Darken.visible = isPaused
	$MoveAboveEverything/UI.visible = isPaused

	if !isPaused:
		return

	if Input.is_action_just_pressed("pause"):
		TheSound.select()
		hide()
		get_tree().paused = false
		return
		
	_handleInput()



func initBeforeShow():
	_selectWeapons()
	_selectWeaponItem(1)
	_selectSubsystemItem(1)
	_selectCargoItem(1)


func _selectWeapons():
	_isWeaponsSelected = true
	_isSubsystemsSelected = false
	_isCargoSelected = false
	$MoveAboveEverything/UI/Weapons/SelectionIndicator.show()
	$MoveAboveEverything/UI/Subsystems/SelectionIndicator.hide()
	$MoveAboveEverything/UI/Cargo/SelectionIndicator.hide()



func _selectSubsystems():
	_isWeaponsSelected = false
	_isSubsystemsSelected = true
	_isCargoSelected = false
	$MoveAboveEverything/UI/Weapons/SelectionIndicator.hide()
	$MoveAboveEverything/UI/Subsystems/SelectionIndicator.show()
	$MoveAboveEverything/UI/Cargo/SelectionIndicator.hide()



func _selectCargo():
	_isWeaponsSelected = false
	_isSubsystemsSelected = false
	_isCargoSelected = true
	$MoveAboveEverything/UI/Weapons/SelectionIndicator.hide()
	$MoveAboveEverything/UI/Subsystems/SelectionIndicator.hide()
	$MoveAboveEverything/UI/Cargo/SelectionIndicator.show()



func _handleInput():
	if Input.is_action_just_pressed("ui_up"):
		if _isSubsystemsSelected:
			_selectWeapons()
			TheSound.select()
		elif _isCargoSelected:
			_selectSubsystems()
			TheSound.select()

	elif Input.is_action_just_pressed("ui_down"):
		if _isWeaponsSelected:
			_selectSubsystems()
			TheSound.select()
		elif _isSubsystemsSelected:
			_selectCargo()
			TheSound.select()

	elif Input.is_action_just_pressed("ui_right"):
		if _isWeaponsSelected:
			if _weaponSelected >= 4:
				return
			_weaponSelected += 1
			_selectWeaponItem(_weaponSelected)
		elif _isSubsystemsSelected:
			if _subsystemSelected >= 3:
				return
			_subsystemSelected += 1
			_selectSubsystemItem(_subsystemSelected)
		elif _isCargoSelected:
			if _isCargoSelected:
				if _cargoSelected >= 4:
					return
				_cargoSelected += 1
				_selectCargoItem(_cargoSelected)

	elif Input.is_action_just_pressed("ui_left"):
		if _isWeaponsSelected:
			if _weaponSelected <= 1:
				return
			_weaponSelected -= 1
			_selectWeaponItem(_weaponSelected)
		elif _isSubsystemsSelected:
			if _subsystemSelected <= 1:
				return
			_subsystemSelected -= 1
			_selectSubsystemItem(_subsystemSelected)
		elif _isCargoSelected:
			if _isCargoSelected:
				if _cargoSelected <= 1:
					return
				_cargoSelected -= 1
				_selectCargoItem(_cargoSelected)


func _selectWeaponItem(index):
	_weaponSelected = index
	$MoveAboveEverything/UI/Weapons/GunFW1.deselect()
	$MoveAboveEverything/UI/Weapons/GunFW2.deselect()
	$MoveAboveEverything/UI/Weapons/GunBW.deselect()
	$MoveAboveEverything/UI/Weapons/GunBomb.deselect()
	if index == 1: $MoveAboveEverything/UI/Weapons/GunFW1.select()
	elif index == 2: $MoveAboveEverything/UI/Weapons/GunFW2.select()
	elif index == 3: $MoveAboveEverything/UI/Weapons/GunBW.select()
	elif index == 4: $MoveAboveEverything/UI/Weapons/GunBomb.select()



func _selectSubsystemItem(index):
	_subsystemSelected = index
	$MoveAboveEverything/UI/Subsystems/Engine.deselect()
	$MoveAboveEverything/UI/Subsystems/Armor.deselect()
	$MoveAboveEverything/UI/Subsystems/Shield.deselect()
	if index == 1: $MoveAboveEverything/UI/Subsystems/Engine.select()
	elif index == 2: $MoveAboveEverything/UI/Subsystems/Armor.select()
	elif index == 3: $MoveAboveEverything/UI/Subsystems/Shield.select()




func _selectCargoItem(index):
	_cargoSelected = index
	$MoveAboveEverything/UI/Cargo/Slot1.deselect()
	$MoveAboveEverything/UI/Cargo/Slot2.deselect()
	$MoveAboveEverything/UI/Cargo/Slot3.deselect()
	$MoveAboveEverything/UI/Cargo/Slot4.deselect()
	if index == 1: $MoveAboveEverything/UI/Cargo/Slot1.select()
	elif index == 2: $MoveAboveEverything/UI/Cargo/Slot2.select()
	elif index == 3: $MoveAboveEverything/UI/Cargo/Slot3.select()
	elif index == 4: $MoveAboveEverything/UI/Cargo/Slot4.select()
