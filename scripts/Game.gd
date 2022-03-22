extends Node2D



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
