extends Control

@onready var progress_bar: ProgressBar = $DolorPrograssBar

var current_value: float = 0.0
var max_value: float = 1.0

func _ready() -> void:
    if progress_bar:
        progress_bar.max_value = max_value
        progress_bar.value = clamp(current_value, 0, max_value)

func set_max(val: float) -> void:
    max_value = val
    if progress_bar:
        progress_bar.max_value = max_value
        progress_bar.value = clamp(progress_bar.value, 0, max_value)

func set_current(val: float) -> void:
    current_value = val
    if progress_bar:
        progress_bar.value = clamp(current_value, 0, max_value)

func increase(amount: float) -> void:
    current_value = clamp(current_value + amount, 0, max_value)
    if progress_bar:
        progress_bar.value = current_value

func decrease(amount: float) -> void:
    current_value = clamp(current_value - amount, 0, max_value)
    if progress_bar:
        progress_bar.value = current_value
