extends Node2D

@onready var game_manager: Node = $GameManager
@onready var zona_1: Area2D = $zona1
@onready var zona_2: Area2D = $zona2

var current_zone: Area2D = null

func _ready() -> void:
	zona_1.input_pickable = true
	zona_2.input_pickable = true
	_update_zone_under_mouse()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_update_zone_under_mouse()

func _update_zone_under_mouse() -> void:
	var space := get_world_2d().direct_space_state
	var p := get_viewport().get_mouse_position()

	var params := PhysicsPointQueryParameters2D.new()
	params.position = p
	params.collide_with_areas = true
	params.collide_with_bodies = false
	# Optional: restrict to a mask if you use layers
	# params.collision_mask = 1 << 0

	var hits := space.intersect_point(params, 32)

	var best: Area2D = null
	for h in hits:
		var a := h.collider as Area2D
		if a == null:
			continue
		# choose a rule for "which one wins" if overlapping:
		if best == null or a.z_index > best.z_index:
			best = a

	if best == current_zone:
		return

	current_zone = best

	if current_zone == zona_1:
		game_manager.zona1_act()
	elif current_zone == zona_2:
		game_manager.zona2_act()
	else:
		game_manager.reset_spank()
