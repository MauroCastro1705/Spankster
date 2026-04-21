## placer bar
extends "res://Components/barras/ProgressBarController.gd"

func _ready() -> void:
	current_value = 0
	set_max(Global.placer_max)
	set_current(current_value)

func set_value() -> void:
	set_max(Global.placer_max)
	set_current(current_value)

func update_placer(new_value) -> void:
	increase(new_value)

func disminuir_placer(value) -> void:
	decrease(value)
