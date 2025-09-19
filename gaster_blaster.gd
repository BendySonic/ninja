extends Area2D

@onready var raycast: RayCast2D = get_node("RayCast2D")
var collision_point := Vector2(0, 0)


func _physics_process(delta: float) -> void:
	collision_point = raycast.get_collision_point()
	queue_redraw()

func _draw() -> void:
	draw_line(Vector2(0, 0), to_local(collision_point), Color.WHITE, 15.0)
