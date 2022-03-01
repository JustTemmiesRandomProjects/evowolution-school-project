extends Node2D

onready var timer = $Timer

const frog = preload("res://Animals/Frog.tscn")

#func _on_Timer_timeout() -> void:
func _process(delta: float) -> void:
	if get_parent().get_child_count() <= 251:
		var spawnee = frog.instance()
		spawnee.position = Vector2(rand_range(-500, 500),rand_range(-500, 500))
		get_parent().add_child(spawnee)
