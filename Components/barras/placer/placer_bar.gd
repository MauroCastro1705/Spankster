## placer bar
extends Control
@onready var dolor_prograss_bar: ProgressBar = $DolorPrograssBar

var max_dolor:int
var current_placer:int

func _ready() -> void:
	current_placer = 0
	

func set_value():
	dolor_prograss_bar.max_value = Global.placer_max
	dolor_prograss_bar.value = current_placer


func update_placer(new_value: int):
	current_placer += new_value
	dolor_prograss_bar.value = current_placer
	print("se updateo el Dolor")

func disminuir_placer(value:int):
	current_placer -= value
	dolor_prograss_bar.value = current_placer
	print("se updateo el Dolor")
