## tolerancia bar
extends "res://Components/barras/ProgressBarController.gd"

# TOLERANCIA BAR
func _ready() -> void:
	# default to full bar; GameManager should override max/current as needed
	current_value = max_value
	set_current(current_value)

func set_value() -> void:
	set_current(current_value)

func update_tolerancia(new_value: float) -> void:
	increase(new_value)

func disminuir_tolerancia(value: float) -> void:
	decrease(value)
