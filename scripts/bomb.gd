extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if $Sprite.timer >= 48:
		$Sprite2.scale += Vector2(25*delta,25*delta)
		if $Sprite2.R > 1.05:
			$Sprite2.R -= 3*delta
		if $Sprite2.R < 0.95:
			$Sprite2.R += 3*delta


func _on_Sprite_boom() -> void:
	for x in $Area2D.get_overlapping_bodies():
		x.queue_free()
