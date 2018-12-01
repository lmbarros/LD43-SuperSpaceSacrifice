extends Node


func playInGameMusic():
	stopMusic()
	$InGameMusic.play()



func stopMusic():
	$InGameMusic.stop()



func smallLaser():
	$SmallLaser.play()



func crash():
	$Crash.play()



func hit():
	$Hit.play()



func smallExplosion():
	$SmallExplosion.play()



func mediumExplosion():
	$MediumExplosion.play()
