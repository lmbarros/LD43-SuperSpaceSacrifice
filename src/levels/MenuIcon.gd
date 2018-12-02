extends Node2D
tool # so that the label is updated on the editor

export(String) var label = "A longish label"


func _process(delta):
	$Label.text = label



func _ready():
	deselect()



func setImage(path):
	$Sprite.texture = load(path)



func select():
	$SelectionRect.show()



func deselect():
	$SelectionRect.hide()



func man():
	$MannedSprite.visible = true



func unman():
	$MannedSprite.visible = false
