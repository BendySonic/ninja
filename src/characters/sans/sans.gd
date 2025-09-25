extends Player

var _gaster_blaster: PackedScene = preload("res://src/characters/sans/gaster_blaster.tscn")

var _gdb = Vector2(65, -5)

func _physics_process(delta: float) -> void:
	super(delta)

func _ability1() -> bool:
	var gb = _gaster_blaster.instantiate()
	gb.global_position = global_position + Vector2(_gdb.x*_look, _gdb.y)
	gb.scale.x = _look
	get_parent().add_child(gb)
	return true
