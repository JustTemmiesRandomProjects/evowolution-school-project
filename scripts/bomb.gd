extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

const explosion = preload("res://Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_Sprite_boom() -> void:
	var boom = explosion.instance()
	boom.position = position
	get_parent().add_child(boom)
	for x in $Area2D.get_overlapping_bodies():
		x.queue_free()
