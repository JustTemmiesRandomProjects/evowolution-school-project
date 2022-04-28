extends CanvasLayer

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("1"):
		hotbar(1)
		Stats.beAfraid = false
	elif Input.is_action_just_pressed("2"):
		hotbar(2)
	elif Input.is_action_just_pressed("3"):
		hotbar(3)
	elif Input.is_action_just_pressed("4"):
		hotbar(4)
	elif Input.is_action_just_pressed("5"):
		hotbar(5)
	elif Input.is_action_just_pressed("6"):
		hotbar(6)
	elif Input.is_action_just_pressed("7"):
		hotbar(7)
	elif Input.is_action_just_pressed("8"):
		hotbar(8)
	elif Input.is_action_just_pressed("9"):
		hotbar(9)
	elif Input.is_action_just_pressed("inventory"):
		open_inv()

func open_inv():
	$Panel/Selected.rect_position.x = (9000)
	if $Inventory.is_visible_in_tree():
		$Inventory.hide()
	else:
		$Inventory.show()


func hotbar(pos):
	$Panel/Selected.rect_position.x = (24+(pos-1)*80)
	Stats.hotbar = pos
	Stats.beAfraid = true
