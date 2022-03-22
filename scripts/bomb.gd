extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_Sprite_boom() -> void:
	for x in $Area2D.get_overlapping_bodies():
		x.queue_free()
	queue_free()
