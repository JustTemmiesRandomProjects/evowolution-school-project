extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 150


var frog = load("res://Animals/Frog.tscn")

enum {
	IDLE,
	WANDER,
	LURED,
	FUCKY
}

var velocity = Vector2.ZERO

var fuckCooldown = 4
var setFuckCooldown = 1

var size = 1.5
var fear_of_player = 5



var state = IDLE

var animal = "frog"
var last_ray = -10

onready var sprite = $Sprite
onready var softCollision = $wanderController/SoftCollision
onready var fuckBox = $wanderController/FuckBox
onready var lureBox = $wanderController/LureBox
onready var wanderController = $wanderController
onready var particles = $Particles2D


func _ready() -> void:
	set_scale(Vector2(size,size))
	randomize()
	
	particles.emitting = false
	$wanderController/FuckBox.monitorable = false
	$wanderController/FuckBox.monitoring = false

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
			if Stats.beAfraid or (not lureBox.is_colliding()):
				update_wander()
				
				
		FUCKY:
			fuckBox.monitorable = true
			fuckBox.monitoring = true
			var rays = get_shortest_ray()
			if rays >= 0:
				var the_ray = $RayCasts.get_child(rays)
				accelerate_towards_point(the_ray.get_collision_point(), delta)
				last_ray = rays
			
			elif last_ray >= 0:
				var the_ray = $RayCasts.get_child(last_ray)
				accelerate_towards_point(the_ray.get_collision_point(), delta)


			if fuckBox.is_colliding() and fuckCooldown <= 0:
		
				var fucker = fuckBox.get_overlapping_areas(); fucker = fucker[0].get_parent().get_parent()
				var fuckSprite = fucker.get_children()[1]
				if fucker.state == FUCKY:
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
					sizeAndRand(fucker.size, size), setFuckCooldown+10,
					everythingelseAndRand(fucker.fear_of_player, fear_of_player))

					fuckCooldown = setFuckCooldown
					fucker.fuckCooldown = setFuckCooldown
					
					fucker.update_wander()
					
					$timer005s.start()
				
					update_wander()




	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 300 * (fear_of_player/5)

	if state != FUCKY:
		fuckBox.monitorable = false
		fuckBox.monitoring = false

	fuckCooldown -= 1*delta
	
	if lureBox.is_colliding() and not Stats.beAfraid and not particles.emitting:
		state = LURED

	
	if velocity.y <= -10:
		$Sprite.frame = 1
	elif velocity.y >= 10:
		$Sprite.frame = 0
	velocity = move_and_slide(velocity)

func colourAndRand(colour1, colour2):
	return (colour1+colour2)/2 + (rand_range(-abs(abs(colour1)-abs(colour2)), (abs(abs(colour1)-abs(colour2)))/1.2))/Stats.colour_muation_rate
	
func sizeAndRand(colour1, colour2):
	return (colour1+colour2)/2 + (rand_range(-abs(abs(colour1)-abs(colour2)), abs(abs(colour1)-abs(colour2))))/Stats.size_mutation_rate

func everythingelseAndRand(colour1, colour2):
	return (colour1+colour2)/2 + (rand_range(-abs(abs(colour1)-abs(colour2)), abs(abs(colour1)-abs(colour2))))/Stats.other_mutation_rate

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func get_shortest_ray():
	var shortest_length = INF
	var shortest_ray = null
	var ray_number = -10
	
	for i in range(0,$RayCasts.get_child_count()):
		var ray = $RayCasts.get_children()[i]
		if ray.is_colliding():
			var length = (ray.get_collision_point()-ray.position).length_squared()
			if length < shortest_length:
				shortest_length = length
				shortest_ray = ray
				ray_number = i

	return ray_number


func update_wander():
	fuckBox.monitorable = false
	fuckBox.monitoring = false
	particles.emitting = false
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer()

func spawn(position, r, g, b, size, cooldown, fearness):
	var spawnee = frog.instance()
	spawnee.position = position
	var sprite = spawnee.get_children()
	sprite = sprite[1]
	sprite.R = r + rand_range(-0.1, 0.1)
	sprite.G = g + rand_range(-0.1, 0.1)
	sprite.B = b + rand_range(-0.1, 0.1)
	spawnee.size = size + rand_range(-0.15, 0.15)
	spawnee.fear_of_player = fearness
	spawnee.fuckCooldown = cooldown
	get_parent().add_child(spawnee)

func _on_FuckBox_input_event(viewport, event, shape_idx):
	if Input.get_action_strength("click"):
		if fuckCooldown <= 0:
		
			particles.emitting = true
			$wanderController/FuckBox.monitorable = true
			$wanderController/FuckBox.monitoring = true
			$InterestedTimer.start()
			state = FUCKY


func _on_20thTimer_timeout() -> void:
	update_wander()


func _on_InterestedTimer_timeout() -> void:
	update_wander()
