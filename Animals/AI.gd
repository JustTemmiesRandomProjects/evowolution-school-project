extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 150

enum {
	IDLE,
	WANDER
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = IDLE

onready var sprite = $Sprite
onready var softCollision = $SoftCollision
onready var wanderController = $wanderController

func _ready() -> void:
	randomize()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 100 * delta)# friction * delta
	knockback = move_and_slide(knockback)
	
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

			if wanderController.get_time_left() <= 0.2:
				update_wander()
				
				
		WANDER:
			if wanderController.get_time_left() <= 0.2:
				update_wander()
				
			accelerate_towards_point(wanderController.target_position, delta)

			if global_position.distance_to(wanderController.target_position) <= MAX_SPEED * delta:
				update_wander()

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 300
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer()
