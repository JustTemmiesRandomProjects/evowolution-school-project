extends Node2D

const top_fence = preload("res://assets/top_fence.png")
const bottom_fence = preload("res://assets/bottom_fence.png")
const fence_gate = preload("res://assets/fence.png")
const bomb_display = preload("res://assets/bombsdisplay.png")

func _on_GameTick_timeout() -> void:
	$CanvasLayer/Label.text = "Coins: " + str(Stats.coins)

func _input(event):
	if InputEventMouseMotion:
		if Stats.hotbar == 3:
			$Fence.texture = bottom_fence
		elif Stats.hotbar == 4:
			$Fence.texture = top_fence
		elif Stats.hotbar == 5:
			$Fence.texture = fence_gate
		elif Stats.hotbar == 6:
			$Fence.texture = bomb_display
		else:
			$Fence.hide()
		
		if Stats.hotbar == 3 or Stats.hotbar == 4 or Stats.hotbar == 5 or Stats.hotbar == 6:
			$Fence.show()
			$Fence.position = get_global_mouse_position()-Vector2(512,300)
