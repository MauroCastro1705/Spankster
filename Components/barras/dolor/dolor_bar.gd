extends "res://Components/barras/ProgressBarController.gd"

func _ready() -> void:
	current_value = 0
	set_current(current_value)

func set_value() -> void:
	set_current(current_value)

func update_dolor(new_value: int) -> void:
	increase(new_value)

func disminuir_dolor(value: int) -> void:
	decrease(value)
