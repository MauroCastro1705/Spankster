## tolerancia bar
extends Control
#TOLERANCIA BAR

@onready var dolor_prograss_bar: ProgressBar = $DolorPrograssBar

var max_dolor:float
var current_tolerancia:float

func _ready() -> void:
	current_tolerancia = Global.tolerancia_max
	

func set_value():
	dolor_prograss_bar.max_value = Global.tolerancia_max
	dolor_prograss_bar.value = current_tolerancia


func update_tolerancia(new_value: float):
	current_tolerancia += new_value
	dolor_prograss_bar.value = current_tolerancia
	print("se updateo la tolerancia")

func disminuir_tolerancia(value:float):
	current_tolerancia -= value
	dolor_prograss_bar.value = current_tolerancia
	print("se updateo el tolerancia")
