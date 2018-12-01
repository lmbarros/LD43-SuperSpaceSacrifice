extends Node


func playInGameMusic():
	stopMusic()
	$InGameMusic.play()



func stopMusic():
	$InGameMusic.stop()



func smallLaser():
	$SmallLaser.play()



func mediumLaser():
	$MediumLaser.play()



func largeLaser():
	$LargeLaser.play()



func missile():
	$Missile.play()



func smallExplosion():
	$SmallExplosion.play()



func mediumExplosion():
	$MediumExplosion.play()



func largeExplosion():
	$LargeExplosion.play()



func crash():
	$Crash.play()



func hit():
	$Hit.play()



func select():
	$Select.play()



func powerUp():
	$PowerUp.play()
