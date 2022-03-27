extends KinematicBody2D

const ACCELERATION = 400*3
const MAX_SPEED = 80*3
const ROLL_SPEED = 110*3
const FRICTION = 450*3

var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

const topfence = preload("res://VerticalFence.tscn")
const bottomfence = preload("res://HorizontalFence.tscn")
const fencegate = preload("res://HorizontalFenceGATE.tscn")
const bomb = preload("res://bomb.tscn")


func _ready():
	#randomize()# randomizes the seed for the game, godot uses a set seed for the game by default
	animationTree.active = true

func _physics_process(delta):
	move_state(delta)


func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()


	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		#animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		#animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)


	move()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and $BuildCooldown.is_stopped():
		var fence = null
		if Stats.hotbar == 3:
			fence = bottomfence.instance()
		elif Stats.hotbar == 4:
			fence = topfence.instance()
		elif Stats.hotbar == 5:
			fence = fencegate.instance()
		elif Stats.hotbar == 6:
			if Stats.coins >= 30:
				Stats.coins -= 30
				var bomba = bomb.instance()
				bomba.position = get_global_mouse_position()-Vector2(512,300)
				get_parent().add_child(bomba)
		if Stats.hotbar == 3 or Stats.hotbar == 4 or Stats.hotbar == 5:
			if Stats.coins >= 10:
				fence.position = get_global_mouse_position()-Vector2(512,300)
				get_parent().add_child(fence)
				Stats.coins -= 10
		
		$BuildCooldown.start()
		

func move():
	velocity = move_and_slide(velocity)
