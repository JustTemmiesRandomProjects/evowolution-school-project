extends Node2D

const top_fence = preload("res://assets/top_fence.png")
const bottom_fence = preload("res://assets/bottom_fence.png")
const fence_gate = preload("res://assets/fence.png")
const bomb_display = preload("res://assets/bombsdisplay.png")

func _on_GameTick_timeout() -> void:
	$CanvasLayer/Label.text = "Coins: " + str(Stats.coins)

func _process(delta: float) -> void:
	if Stats.fade_out:
		if $CanvasLayer/Fadeout.color.a < 1:
			$CanvasLayer/Fadeout.color.a += .01
		else:
			Stats.fade_out = false
	
	elif Stats.fade_in:
		if $CanvasLayer/Fadeout.color.a > 0:
			$CanvasLayer/Fadeout.color.a -= .01
		else:
			Stats.fade_in = false
	
	else:
		if $CanvasLayer/Fadeout/FadeTime.is_stopped():
			$CanvasLayer/Fadeout/FadeTime.start()


func _on_FadeTime_timeout() -> void:
	if Stats.fade_out or Stats.fade_in:
		pass
	else:
		$CanvasLayer/Fadeout.color.a = 0

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
