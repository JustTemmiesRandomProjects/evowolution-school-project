extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Stats.fade_in = true

func _process(delta: float) -> void:
	if Stats.fade_out:
		if $Fade.color.a < 1:
			$Fade.color.a += .01
		else:
			Stats.fade_out = false
	
	elif Stats.fade_in:
		if $Fade.color.a > 0:
			$Fade.color.a -= .01
		else:
			Stats.fade_in = false

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Character":
		Stats.fade_out = true
		Stats.fade_in = false
		if $JojaTimerInside.is_stopped():
			$JojaTimerInside.start()


func _on_JojaTimerInside_timeout():
	get_tree().change_scene("res://Game.tscn")
