extends Area2D

@onready var raycast: RayCast2D = get_node("RayCast2D")
@onready var laser: MeshInstance2D = get_node("Laser")
@onready var animation: AnimationPlayer = get_node("AnimationPlayer")
var collision_point := Vector2(0, 0)


func _physics_process(delta: float) -> void:
	collision_point = raycast.get_collision_point()
	var cpl
	if collision_point == Vector2(0, 0):
		cpl = 6000
	else:
		cpl = (global_position - collision_point).length()
	laser.mesh.size.x = cpl*2
	laser.position.x = cpl/2

func _ready() -> void:
	animation.play("shoot")
