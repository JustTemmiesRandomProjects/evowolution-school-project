extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Character":
		Stats.fade_out = true
		Stats.fade_in = false
		
		if $JojaTimer.is_stopped():
			$JojaTimer.start()
		


func _on_JojaTimer_timeout() -> void:
	get_tree().change_scene("res://InsideJoja.tscn")
