extends Node

# Public configuration
var spank_timer: float = 1.0

signal gameOver
signal stat_changed(stat_name, value)

# Internal state
var _placer: int = 0
var placer_max: int = 100

var _dolor: int = 0
var dolor_max: int = 100

var _tolerancia: int = 100 # va disminuyendo
var tolerancia_max: int = 100

var player_score: int = 0

func _ready() -> void:
	gameOver.connect(score_calculation)

func score_calculation() -> void:
	print("---game over----")
	player_score = _placer + _dolor
	print("player score: ", player_score)

func get_placer() -> float:
	return _placer

func get_dolor() -> float:
	return _dolor

func get_tolerancia() -> int:
	return _tolerancia

func set_placer(value: int) -> void:
	_placer = clamp(value, 0, placer_max)
	emit_signal("stat_changed", "placer", _placer)

func set_dolor(value: int) -> void:
	_dolor = clamp(value, 0, dolor_max)
	emit_signal("stat_changed", "dolor", _dolor)

func set_tolerancia(value: int) -> void:
	_tolerancia = clamp(value, 0, tolerancia_max)
	emit_signal("stat_changed", "tolerancia", _tolerancia)

func add_placer(amount: int) -> void:
	set_placer(_placer + amount)

func add_dolor(amount: int) -> void:
	set_dolor(_dolor + amount)

func reduce_tolerancia(amount: int) -> void:
	set_tolerancia(_tolerancia - amount)
