extends CanvasLayer

func _input(event: InputEvent) -> void:
	if Input.get_action_strength("1"):
		hotbar(1)
		Stats.beAfraid = false
	elif Input.get_action_strength("2"):
		hotbar(2)
	elif Input.get_action_strength("3"):
		hotbar(3)
	elif Input.get_action_strength("4"):
		hotbar(4)
	elif Input.get_action_strength("5"):
		hotbar(5)
	elif Input.get_action_strength("6"):
		hotbar(6)
	elif Input.get_action_strength("7"):
		hotbar(7)

func hotbar(pos):
	$Panel/Selected.rect_position.x = (24+(pos-1)*80)
	Stats.hotbar = pos
	print(Stats.hotbar)
	Stats.beAfraid = true
