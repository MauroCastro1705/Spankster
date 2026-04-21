extends Node

# Public configuration
var spank_timer: float = 1.0

signal gameOver
signal stat_changed(stat_name, value)

# Internal state
var _placer: float = 0
var placer_max: float = 100

var _dolor: float = 0
var dolor_max: float = 100

var _tolerancia: float = 100 # va disminuyendo
var tolerancia_max: float = 100

var player_score: float = 0

func _ready() -> void:
	gameOver.connect(score_calculation)

func score_calculation() -> void:
	print("---game over----")
	player_score = _placer + _dolor
	print(player_score)

func get_placer() -> float:
	return _placer

func get_dolor() -> float:
	return _dolor

func get_tolerancia() -> float:
	return _tolerancia

func set_placer(value: float) -> void:
	_placer = clamp(value, 0, placer_max)
	emit_signal("stat_changed", "placer", _placer)

func set_dolor(value: float) -> void:
	_dolor = clamp(value, 0, dolor_max)
	emit_signal("stat_changed", "dolor", _dolor)

func set_tolerancia(value: float) -> void:
	_tolerancia = clamp(value, 0, tolerancia_max)
	emit_signal("stat_changed", "tolerancia", _tolerancia)

func add_placer(amount: float) -> void:
	set_placer(_placer + amount)

func add_dolor(amount: float) -> void:
	set_dolor(_dolor + amount)

func reduce_tolerancia(amount: float) -> void:
	set_tolerancia(_tolerancia - amount)
