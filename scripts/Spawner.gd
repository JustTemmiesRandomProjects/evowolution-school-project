extends Node2D

onready var timer = $Timer

const frog = preload("res://Animals/Frog.tscn")

#func _on_Timer_timeout() -> void:
func _process(delta: float) -> void:
	if get_parent().get_child_count() <= 30:
		spawn(Vector2(rand_range(-500, 500),rand_range(-500, 500)), 0, 0, 0, 1.5)

func spawn(position, r, g, b, size):
	var spawnee = frog.instance()
	spawnee.position = position
	var sprite = spawnee.get_children()
	sprite = sprite[1]
	sprite.R = r + rand_range(-0.1, 0.1)
	sprite.G = g + rand_range(-0.1, 0.1)
	sprite.B = b + rand_range(-0.1, 0.1)
	spawnee.size = size + rand_range(-0.1, 0.1)
	get_parent().add_child(spawnee)