extends Node2D

onready var timer = $Timer

const frog = preload("res://Animals/Frog.tscn")

func _on_Timer_timeout() -> void:
#func _process(delta: float) -> void:
	if get_parent().get_child_count() <= 10:
		spawn(Vector2(rand_range(-50, 50),rand_range(-50, 50)), rand_range(-0.12,0.2), rand_range(-0.12,0.2), rand_range(-0.12,0.2), 1.5, 6)
		#spawn(Vector2(rand_range(-50, 50),rand_range(-50, 50)), 0, 0, 0, 1.5, 6)

func spawn(position, r, g, b, size, cooldown):
	var spawnee = frog.instance()
	spawnee.position = position
	var sprite = spawnee.get_children()
	sprite = sprite[1]
	sprite.R = r + rand_range(-0.1, 0.1)
	sprite.G = g + rand_range(-0.1, 0.1)
	sprite.B = b + rand_range(-0.1, 0.1)
	spawnee.size = size + rand_range(-0.15, 0.15)
	spawnee.fuckCooldown = cooldown
	get_parent().add_child(spawnee)

