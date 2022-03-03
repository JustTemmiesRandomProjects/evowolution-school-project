extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 150

enum {
	IDLE,
	WANDER
}

var velocity = Vector2.ZERO

var fuckCooldown = 2

var size = rand_range(1,2)



var state = IDLE

var animal = "frog"

onready var sprite = $Sprite
onready var softCollision = $wanderController/SoftCollision
onready var fuckBox = $wanderController/FuckBox
onready var wanderController = $wanderController


func _ready() -> void:
	set_scale(Vector2(size,size))
	randomize()

func _physics_process(delta):	

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
	
	if fuckBox.is_colliding() and fuckCooldown <= 0:
		#Spawner.spawn(get_position(), $Sprite.R, $Sprite.G, $Sprite.B, size)
		#var fucker = fuckBox.get_overlapping_bodies().erase(self)
		#print(fucker)
		var fucker = fuckBox.get_overlapping_areas(); fucker = fucker[0].get_parent().get_parent()
		var sprite = fucker.get_children()[1]
		print(abs(fucker.size-size))
		print(abs(abs(sprite.R)-abs($Sprite.R)))
		print(abs(abs(sprite.G)-abs($Sprite.G)))
		print(abs(abs(sprite.B)-abs($Sprite.B)))
		fuckCooldown = 10
	
	fuckCooldown -= 1*delta
	

	
	if velocity.y <= -5:
		$Sprite.frame = 1
	elif velocity.y >= 5:
		$Sprite.frame = 0
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
