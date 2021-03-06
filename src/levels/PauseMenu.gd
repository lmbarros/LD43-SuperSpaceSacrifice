extends Popup

var _isShown = false

var _isWeaponsSelected = false
var _isSubsystemsSelected = false
var _isCargoSelected = false

# Indices; first valid index is 1
var _weaponSelected = 0
var _subsystemSelected = 0
var _cargoSelected = 0



func _process(delta):
	$MoveAboveGame/BGFX.visible = _isShown
	$MoveAboveBGFX/Darken.visible = _isShown
	$MoveAboveEverything/UI.visible = _isShown

	var isPaused = get_tree().paused

	if !_isShown:
		return

	if !isPaused:
		return

	if Input.is_action_just_pressed("pause"):
		TheSound.select()
		hide()
		_isShown = false
		get_tree().paused = false
		return

	_handleInput()



func initBeforeShow():
	_isShown = true
	_selectWeapons()
	_selectWeaponItem(1)
	_selectSubsystemItem(1)
	_selectCargoItem(1)
	_updateImages()
	_updateInfo()
	_updateHelp()



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
			_updateInfoAndHelp()
		elif _isCargoSelected:
			_selectSubsystems()
			TheSound.select()
			_updateInfoAndHelp()

	elif Input.is_action_just_pressed("ui_down"):
		if _isWeaponsSelected:
			_selectSubsystems()
			TheSound.select()
			_updateInfoAndHelp()
		elif _isSubsystemsSelected:
			_selectCargo()
			TheSound.select()
			_updateInfoAndHelp()

	elif Input.is_action_just_pressed("ui_right"):
		if _isWeaponsSelected:
			if _weaponSelected >= 4:
				return
			_weaponSelected += 1
			_selectWeaponItem(_weaponSelected)
			TheSound.select()
			_updateInfoAndHelp()
		elif _isSubsystemsSelected:
			if _subsystemSelected >= 3:
				return
			_subsystemSelected += 1
			_selectSubsystemItem(_subsystemSelected)
			TheSound.select()
			_updateInfoAndHelp()
		elif _isCargoSelected:
			if _cargoSelected >= 4:
				return
			_cargoSelected += 1
			_selectCargoItem(_cargoSelected)
			TheSound.select()
			_updateInfoAndHelp()

	elif Input.is_action_just_pressed("ui_left"):
		if _isWeaponsSelected:
			if _weaponSelected <= 1:
				return
			_weaponSelected -= 1
			_selectWeaponItem(_weaponSelected)
			TheSound.select()
			_updateInfoAndHelp()
		elif _isSubsystemsSelected:
			if _subsystemSelected <= 1:
				return
			_subsystemSelected -= 1
			_selectSubsystemItem(_subsystemSelected)
			TheSound.select()
			_updateInfoAndHelp()
		elif _isCargoSelected:
			if _cargoSelected <= 1:
				return
			_cargoSelected -= 1
			_selectCargoItem(_cargoSelected)
			TheSound.select()
			_updateInfoAndHelp()

	elif Input.is_action_just_pressed("man"):
		_manUnman()

	elif Input.is_action_just_pressed("swap_item"):
		_swapItem()

	elif Input.is_action_just_pressed("delete_item"):
		_deleteItem()



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



func _updateImages():
	var image = ""
	var manned = false

	if ThePlayer.gunForward1 != null:
		image = ThePlayer.gunForward1.image
		manned = ThePlayer.gunForward1.manned
	else:
		image = "res://subsystems/icon-none.png"
		manned = false
	$MoveAboveEverything/UI/Weapons/GunFW1.setImage(image)
	$MoveAboveEverything/UI/Weapons/GunFW1.setManned(manned)

	if ThePlayer.gunForward2 != null:
		image = ThePlayer.gunForward2.image
		manned = ThePlayer.gunForward2.manned
	else:
		image = "res://subsystems/icon-none.png"
		manned = false
	$MoveAboveEverything/UI/Weapons/GunFW2.setImage(image)
	$MoveAboveEverything/UI/Weapons/GunFW2.setManned(manned)

	if ThePlayer.gunBackward != null:
		image = ThePlayer.gunBackward.image
		manned = ThePlayer.gunBackward.manned
	else:
		image = "res://subsystems/icon-none.png"
		manned = false
	$MoveAboveEverything/UI/Weapons/GunBW.setImage(image)
	$MoveAboveEverything/UI/Weapons/GunBW.setManned(manned)

	if ThePlayer.gunBombBay != null:
		image = ThePlayer.gunBombBay.image
		manned = ThePlayer.gunBombBay.manned
	else:
		image = "res://subsystems/icon-none.png"
		manned = false
	$MoveAboveEverything/UI/Weapons/GunBomb.setImage(image)
	$MoveAboveEverything/UI/Weapons/GunBomb.setManned(manned)

	if ThePlayer.engine != null:
		image = ThePlayer.engine.image
		manned = ThePlayer.engine.manned
	else:
		image = "res://subsystems/icon-none.png"
		manned = false
	$MoveAboveEverything/UI/Subsystems/Engine.setImage(image)
	$MoveAboveEverything/UI/Subsystems/Engine.setManned(manned)

	if ThePlayer.armor != null:
		image = ThePlayer.armor.image
		manned = ThePlayer.armor.manned
	else:
		image = "res://subsystems/icon-none.png"
		manned = false
	$MoveAboveEverything/UI/Subsystems/Armor.setImage(image)
	$MoveAboveEverything/UI/Subsystems/Armor.setManned(manned)

	if ThePlayer.shield != null:
		image = ThePlayer.shield.image
		manned = ThePlayer.shield.manned
	else:
		image = "res://subsystems/icon-none.png"
		manned = false
	$MoveAboveEverything/UI/Subsystems/Shield.setImage(image)
	$MoveAboveEverything/UI/Subsystems/Shield.setManned(manned)

	if ThePlayer.cargo1 != null:
		image = ThePlayer.cargo1.image
	else:
		image = "res://subsystems/icon-none.png"
	$MoveAboveEverything/UI/Cargo/Slot1.setImage(image)

	if ThePlayer.cargo2 != null:
		image = ThePlayer.cargo2.image
	else:
		image = "res://subsystems/icon-none.png"
	$MoveAboveEverything/UI/Cargo/Slot2.setImage(image)

	if ThePlayer.cargo3 != null:
		image = ThePlayer.cargo3.image
	else:
		image = "res://subsystems/icon-none.png"
	$MoveAboveEverything/UI/Cargo/Slot3.setImage(image)

	if ThePlayer.cargo4 != null:
		image = ThePlayer.cargo4.image
	else:
		image = "res://subsystems/icon-none.png"
	$MoveAboveEverything/UI/Cargo/Slot4.setImage(image)



func _updateInfoAndHelp():
	_updateInfo()
	_updateHelp()



func _updateInfo():
	var thing = null

	if _isWeaponsSelected:
		if _weaponSelected == 1:
			thing = ThePlayer.gunForward1
		elif _weaponSelected == 2:
			thing = ThePlayer.gunForward2
		elif _weaponSelected == 3:
			thing = ThePlayer.gunBackward
		elif _weaponSelected == 4:
			thing = ThePlayer.gunBombBay

	elif _isSubsystemsSelected:
		if _subsystemSelected == 1:
			thing = ThePlayer.engine
		elif _subsystemSelected == 2:
			thing = ThePlayer.armor
		elif _subsystemSelected == 3:
			thing = ThePlayer.shield

	elif _isCargoSelected:
		if _cargoSelected == 1:
			thing = ThePlayer.cargo1
		elif _cargoSelected == 2:
			thing = ThePlayer.cargo2
		elif _cargoSelected == 3:
			thing = ThePlayer.cargo3
		elif _cargoSelected == 3:
			thing = ThePlayer.cargo3

	if thing == null:
		$MoveAboveEverything/UI/Info/Label.text = "Empty slot"
		$MoveAboveEverything/UI/Info/Info.text = "Nothing selected"
	else:
		var labelText = thing.type.capitalize() + ": " + thing.label
		if thing.manned:
			labelText += " (Manned)"
		$MoveAboveEverything/UI/Info/Label.text = labelText
		$MoveAboveEverything/UI/Info/Info.text = thing.description

	var crewText = "Crew size: " + str(ThePlayer.crew)
	var un = ThePlayer.getUnassignedCrew()
	if un > 0:
		crewText += ".   Unassigned crew: " + str(un)
	$MoveAboveEverything/UI/Crew/Info.text = crewText	



func _manUnman():
	var thing = null
	if _isWeaponsSelected:
		thing = _getWeaponByIndex(_weaponSelected)
	elif _isSubsystemsSelected:
		thing = _getSubsystemByIndex(_subsystemSelected)
		
	if thing && thing.manned:
		thing.manned = false
		TheSound.select()
	elif thing && !thing.manned && ThePlayer.getUnassignedCrew() > 0:
		thing.manned = true
		TheSound.select()
		

	_updateImages()
	_updateInfoAndHelp()



func _swapItem():
	var cargo = _getCargoByIndex(_cargoSelected)

	if _isWeaponsSelected:
		var weapon = _getWeaponByIndex(_weaponSelected)
		if _weaponSelected != 4: # gun
			if cargo != null && cargo.type != "gun": return

		else: # bomb
			if cargo != null && cargo.type != "bomb": return

		TheSound.select()
		_setCargoByIndex(_cargoSelected, weapon)
		_setWeaponByIndex(_weaponSelected, cargo)
		ThePlayer.adjustFireAngles()

	elif _isSubsystemsSelected:
		var subsystem = _getSubsystemByIndex(_subsystemSelected)
		if _subsystemSelected == 1 && cargo != null && cargo.type != "engine": return
		elif _subsystemSelected == 2 && cargo != null && cargo.type != "armor": return
		elif _subsystemSelected == 3 && cargo != null && cargo.type != "shield": return

		TheSound.select()
		_setCargoByIndex(_cargoSelected, subsystem)
		_setSubsystemByIndex(_subsystemSelected, cargo)


	_updateImages()
	_updateInfoAndHelp()



func _deleteItem():
	if _isWeaponsSelected:
		if _weaponSelected == 1: ThePlayer.gunForward1 = null
		elif _weaponSelected == 2: ThePlayer.gunForward2 = null
		elif _weaponSelected == 3: ThePlayer.gunBackward = null
		elif _weaponSelected == 4: ThePlayer.gunBombBay = null
	elif _isSubsystemsSelected:
		if _subsystemSelected == 1: ThePlayer.engine = null
		elif _subsystemSelected == 2: ThePlayer.armor = null
		elif _subsystemSelected == 3: ThePlayer.shield = null
	elif _isCargoSelected:
		if _cargoSelected == 1: ThePlayer.cargo1 = null
		elif _cargoSelected == 2: ThePlayer.cargo2 = null
		elif _cargoSelected == 3: ThePlayer.cargo3 = null
		elif _cargoSelected == 4: ThePlayer.cargo4 = null

	_updateImages()
	_updateInfoAndHelp()



func _updateHelp():
	var help = "Pause/F1/Esc: Back to game"
	
	if !_isCargoSelected:
		help += "          Enter/Y: Swap item with the selected cargo slot"

	if _isWeaponsSelected:
		help += "          Space/X: Man/Unman the selected weapon (increase fire rate)"
	elif _isSubsystemsSelected:
		help += "          Space/X: Man/Unman the selected subsystem (better performance)"


	help += ""

	$MoveAboveEverything/UI/Help.text = help



func _getWeaponByIndex(i):
	if i == 1: return ThePlayer.gunForward1
	elif i == 2: return ThePlayer.gunForward2
	elif i == 3: return ThePlayer.gunBackward
	elif i == 4: return ThePlayer.gunBombBay



func _setWeaponByIndex(i, w):
	if i == 1: ThePlayer.gunForward1 = w
	elif i == 2: ThePlayer.gunForward2 = w
	elif i == 3: ThePlayer.gunBackward = w
	elif i == 4: ThePlayer.gunBombBay = w



func _getSubsystemByIndex(i):
	if i == 1: return ThePlayer.engine
	elif i == 2: return ThePlayer.armor
	elif i == 3: return ThePlayer.shield



func _setSubsystemByIndex(i, s):
	if i == 1: ThePlayer.engine = s
	elif i == 2: ThePlayer.armor = s
	elif i == 3: ThePlayer.shield = s



func _getCargoByIndex(i):
	if i == 1: return ThePlayer.cargo1
	elif i == 2: return ThePlayer.cargo2
	elif i == 3: return ThePlayer.cargo3
	elif i == 4: return ThePlayer.cargo4



func _setCargoByIndex(i, c):
	if i == 1: ThePlayer.cargo1 = c
	elif i == 2: ThePlayer.cargo2 = c
	elif i == 3: ThePlayer.cargo3 = c
	elif i == 4: ThePlayer.cargo4 = c
