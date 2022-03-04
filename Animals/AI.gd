extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 150

var frog = load("res://Animals/Frog.tscn")

enum {
	IDLE,
	WANDER,
	LURED
}

var velocity = Vector2.ZERO

var fuckCooldown = 4
var setFuckCooldown = 1

var size = rand_range(1,2)



var state = IDLE

var animal = "frog"

onready var sprite = $Sprite
onready var softCollision = $wanderController/SoftCollision
onready var fuckBox = $wanderController/FuckBox
onready var lureBox = $wanderController/LureBox
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
		
		LURED:
			accelerate_towards_point(get_node("/root/Game/YSort/Character").get_position()+Vector2(512,300), delta)
			if fuckBox.is_colliding() and fuckCooldown <= 0:
		
				var fucker = fuckBox.get_overlapping_areas(); fucker = fucker[0].get_parent().get_parent()
				var fuckSprite = fucker.get_children()[1]
				#print(abs(fucker.size-size))
				#print(abs(abs(sprite.R)-abs($Sprite.R)))
				#print(abs(abs(sprite.G)-abs($Sprite.G)))
				#print(abs(abs(sprite.B)-abs($Sprite.B)))
				#print((sprite.R+$Sprite.R)/2)
				#print((sprite.G+$Sprite.G)/2)
				#print((sprite.B+$Sprite.B)/2)
				
				spawn(get_position()+Vector2(rand_range(2,5),rand_range(2,5)),
				colourAndRand(fuckSprite.R, sprite.R),
				colourAndRand(fuckSprite.G, sprite.G),
				colourAndRand(fuckSprite.B, sprite.B),
				avgAndRand(fucker.size, size), setFuckCooldown+10)

				fuckCooldown = setFuckCooldown
				
			if Stats.beAfraid or not lureBox.is_colliding():
				update_wander()


	if softCollision.is_colliding() and state != LURED:
		velocity += softCollision.get_push_vector() * delta * 300
		update_wander()

	fuckCooldown -= 1*delta
	
	if lureBox.is_colliding() and not Stats.beAfraid:
		state = LURED

	
	if velocity.y <= -10:
		$Sprite.frame = 1
	elif velocity.y >= 10:
		$Sprite.frame = 0
	velocity = move_and_slide(velocity)

func colourAndRand(colour1, colour2):
	return (colour1+colour2)/2 + rand_range(-abs(abs(colour1)-abs(colour2)), (abs(abs(colour1)-abs(colour2)))/1.2)
	
func avgAndRand(colour1, colour2):
	return (colour1+colour2)/2 + rand_range(-abs(abs(colour1)-abs(colour2)), abs(abs(colour1)-abs(colour2)))


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
