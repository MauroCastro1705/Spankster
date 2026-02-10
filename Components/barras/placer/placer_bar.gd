## placer bar
extends Control

#PLACER BAR
@onready var dolor_prograss_bar: ProgressBar = $DolorPrograssBar

var max_dolor
var current_placer

func _ready() -> void:
	current_placer = 0
	

func set_value():
	dolor_prograss_bar.max_value = Global.placer_max
	dolor_prograss_bar.value = current_placer


func update_placer(new_value):
	current_placer += new_value
	dolor_prograss_bar.value = current_placer
	print("se updateo el placer")

func disminuir_placer(value):
	current_placer -= value
	dolor_prograss_bar.value = current_placer
	print("se updateo el placer")
