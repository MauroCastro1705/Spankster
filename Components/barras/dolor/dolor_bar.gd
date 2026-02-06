extends Control
@onready var dolor_prograss_bar: ProgressBar = $DolorPrograssBar

var max_dolor:int
var current_dolor:int

func _ready() -> void:
	current_dolor = 0
	

func set_value():
	dolor_prograss_bar.max_value = Global.dolor_max
	dolor_prograss_bar.value = current_dolor


func update_dolor(new_value: int):
	current_dolor += new_value
	dolor_prograss_bar.value = current_dolor

func disminuir_dolor(value:int):
	current_dolor -= value
	dolor_prograss_bar.value = current_dolor
