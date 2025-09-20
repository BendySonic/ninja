class_name Player
extends CharacterBody2D

enum State {IDLE, LEFT, RIGHT, JUMP, FALL, HURT}

const SPEED = 400.0
const JUMP_VELOCITY = -650.0
const WALL_JUMP_VELOCITY = -650.0
const SECOND_JUMP_VELOCITY = -600.0

var _has_second_jump := true
var _state: State = State.IDLE:
	set = _set_state

# Collision
@onready var on_floor: Area2D = get_node("OnFloor")

# Visuals
@onready var wall_particles: GPUParticles2D = get_node("WallParticles")
@onready var jump_particles: GPUParticles2D = get_node("JumpParticles")
@onready var animation_player: Label = get_node("Sprite2D/Animation")


func _physics_process(delta: float) -> void:
	_movement_process(delta)

func _movement_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor() or _is_on_floorc():
		_has_second_jump = true
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or _is_on_floorc()):
		velocity.y = JUMP_VELOCITY
		_set_state(State.JUMP)
	elif Input.is_action_just_pressed("jump") and _has_second_jump:
		velocity.y = SECOND_JUMP_VELOCITY
		jump_particles.emitting = true
		_has_second_jump = false
		_set_state(State.JUMP)
	
	# Direction
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	_ability_input(event)

func _ability_input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		print(1)

func _set_state(value):
	match value:
		State.IDLE:
			_set_animation("idle")
		State.JUMP:
			if _state == State.JUMP:
				_set_animation("jump2")
			else:
				_set_animation("jump1")
		State.IDLE:
			_set_animation("idle")
	_state = value

# Coyote jump
func _is_on_floorc() -> bool:
	return on_floor.has_overlapping_bodies()

func _set_animation(anim_name: String) -> void:
	animation_player.text = anim_name
