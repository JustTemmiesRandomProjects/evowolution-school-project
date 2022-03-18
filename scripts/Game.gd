extends Node2D



func _on_GameTick_timeout() -> void:
	$CanvasLayer/Label.text = "Coins: " + str(Stats.coins)
