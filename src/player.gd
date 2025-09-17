extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const SECOND_JUMP_VELOCITY = -500.0

@onready var on_floor: Area2D = get_node("OnFloor")
@onready var on_wall: Area2D = get_node("OnWall")
@onready var gpu_particles: GPUParticles2D = get_node("GPUParticles2D")

var has_second_jump := true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_on_floor() or is_on_floorc():
		has_second_jump = true
	
	gpu_particles.emitting = is_on_wall()
	# Handle jump.
	if Input.is_action_pressed("jump") and (is_on_floor() or is_on_floorc()):
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("jump") and has_second_jump:
		velocity.y = SECOND_JUMP_VELOCITY
		has_second_jump = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func is_on_floorc() -> bool:
	return on_floor.has_overlapping_bodies()
