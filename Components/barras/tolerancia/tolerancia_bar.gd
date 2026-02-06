## tolerancia bar
extends Control
@onready var dolor_prograss_bar: ProgressBar = $DolorPrograssBar

var max_dolor:int
var current_tolerancia:int

func _ready() -> void:
	current_tolerancia = Global.tolerancia_max
	

func set_value():
	dolor_prograss_bar.max_value = Global.tolerancia_max
	dolor_prograss_bar.value = current_tolerancia


func update_tolerancia(new_value: int):
	current_tolerancia += new_value
	dolor_prograss_bar.value = current_tolerancia
	print("se updateo el Dolor")

func disminuir_tolerancia(value:int):
	current_tolerancia -= value
	dolor_prograss_bar.value = current_tolerancia
	print("se updateo el Dolor")
