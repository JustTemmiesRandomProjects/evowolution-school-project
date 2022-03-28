extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Stats.fade_in = true

func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Character":
		Stats.fade_out = true
		Stats.fade_in = false
		if $JojaTimerInside.is_stopped():
			$JojaTimerInside.start()


func _on_JojaTimerInside_timeout():
	for X in $entrance.get_overlapping_bodies():
		X.position = Vector2(404,-450)
		Stats.fade_in = true
		Stats.fade_out = false
