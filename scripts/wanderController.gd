extends Node2D

export(int) var wander_range = 64

onready var start_position = global_position
onready var target_position = global_position

onready var timer = $Timer


func _ready():
	randomize()
	update_target_position()

func update_target_position():
	start_position = get_global_position()
	var target_vector = Vector2(rand_range(-wander_range, wander_range), rand_range(-wander_range, wander_range))
	target_position = start_position + target_vector

func get_time_left():
	return timer.get_time_left()

func start_wander_timer():
	timer.start(rand_range(1,5))
	update_target_position()


