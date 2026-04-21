## tolerancia bar
extends "res://Components/barras/ProgressBarController.gd"
#TOLERANCIA BAR

func _ready() -> void:
	current_value = Global.tolerancia_max
	set_max(Global.tolerancia_max)
	set_current(current_value)

func set_value() -> void:
	set_max(Global.tolerancia_max)
	set_current(current_value)

func update_tolerancia(new_value: float) -> void:
	increase(new_value)

func disminuir_tolerancia(value: float) -> void:
	decrease(value)
