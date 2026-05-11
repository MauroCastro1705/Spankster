extends Node
class_name GameManager
const FLOGGER = preload("uid://d4jmi1wtnawp0")
const MANO = preload("uid://diboyf6rdn73n")
const PALMETA = preload("uid://bqg0mxbtf6ldd")
const VARILLA = preload("uid://xgad24r2eaci")
@export var hit_vfx_scene: PackedScene
var hit_vfx_parent

const WeaponManagerScript = preload("res://Components/game_manager/weapon_manager.gd")
const DamageCalculatorScript = preload("res://Components/game_manager/damage_calculator.gd")
var weapon_manager = null
var damage_calculator = null



@onready var hit_timer: Timer = $hit_timer
signal spank
@onready var hit_cooldown: Timer = $hit_cooldown
var can_spank_timer := true
var can_spank_zone := false

#barras de stats
@export var Dolor_barra:Control
@export var Placer_barra:Control
@export var Tolerancia_barra:Control

# Max values configurable per-GameManager instance
@export var dolor_max: float = 100.0
@export var placer_max: float = 100.0
@export var tolerancia_max: float = 100.0
@export var herramienta:Control

#sprite
@export var butt_1:Sprite2D

@onready var colorInicial
var colorZona1 := Color(0, 1, 0.5)
var colorZona2 := Color(1, 0.084, 0.08)
var colorSpank
var zona1_multi:float = 1.0
var zona2_multi:float = 1.25
var spank_multi

var weapon = null
var arma_elegida
var weapon_by_action := {}

func _ready() -> void:
	colorInicial = butt_1.modulate
	print(colorInicial)
	spank.connect(se_hizo_spank)
	hit_cooldown.wait_time = Global.spank_timer
	# apply configured max/current values to the bars (decoupled from Global)
	set_ui_values()
	Global.player_score = 0
	# instantiate helper modules
	weapon_manager = WeaponManagerScript.new()
	weapon_manager.load_weapon_registry()
	weapon_by_action = weapon_manager.weapon_by_action
	damage_calculator = DamageCalculatorScript.new()
	# wire exported UI bars into the damage calculator so scenes can configure them
	damage_calculator.setup(Dolor_barra, Placer_barra, Tolerancia_barra)
	# default to arma1 if available
	if weapon_manager.get_default_weapon() != null:
		arma_elegida = weapon_manager.get_default_weapon()
		weapon = arma_elegida
	else:
		arma_elegida = null
		weapon = null

	# connect to zone signals from parent node if present
	var parent = get_parent()
	if parent != null and parent.has_signal("zone_changed"):
		parent.connect("zone_changed", Callable(self, "_on_zone_changed"))
	
func set_ui_values():
	if Dolor_barra:
		Dolor_barra.set_max(dolor_max)
		Dolor_barra.set_current(0)
	if Placer_barra:
		Placer_barra.set_max(placer_max)
		Placer_barra.set_current(0)
	if Tolerancia_barra:
		Tolerancia_barra.set_max(tolerancia_max)
		Tolerancia_barra.set_current(tolerancia_max)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("golpe"):
		hitCulo()
		return

	# weapon selection
	for action in weapon_by_action.keys():
		if event.is_action_pressed(action):
			change_weapon(weapon_by_action[action])
			return

func set_weapon(new_weapon) -> void:
	change_weapon(new_weapon)


func change_weapon(new_weapon) -> void:
	# Keep both references in sync and update the tool UI
	weapon = new_weapon
	arma_elegida = new_weapon
	if herramienta:
		herramienta.select_tool(new_weapon)
		herramienta.set_tool()
	# optional debug print
	# print("Weapon changed to: ", new_weapon.name)
	
func hitCulo():
	if can_spank_timer and can_spank_zone:
		butt_1.modulate = colorSpank
		_spawn_hit_vfx_at_mouse()
		hit_timer.start()
		hit_cooldown.start()
		can_spank_timer = false
		emit_signal("spank")
		
func _spawn_hit_vfx_at_mouse() -> void:
	if hit_vfx_scene == null:
		return

	var vfx := hit_vfx_scene.instantiate() as Node2D
	if vfx == null:
		push_warning("hit_vfx_scene root is not Node2D")
		return

	vfx.global_position = get_viewport().get_mouse_position()

	var parent = hit_vfx_parent
	if parent == null:
		parent = get_tree().current_scene
	parent.add_child(vfx)


func _process(_delta: float) -> void:
	pass# input is handled in _unhandled_input; per-frame checks removed
	

func se_hizo_spank():
	print("spank hecho")
	_apply_damage()

func zona1_act():
	colorSpank = colorZona1
	can_spank_zone = true
	spank_multi = zona1_multi
	print("zona1")

func zona2_act():
	colorSpank = colorZona2
	can_spank_zone = true
	spank_multi = zona2_multi
	print("zona2")

func reset_spank():
	can_spank_zone = false
	colorSpank = colorInicial
	spank_multi = 1
	print("spank reset")


func _on_zone_changed(zone_name):
	if zone_name == "zona1":
		zona1_act()
	elif zone_name == "zona2":
		zona2_act()
	else:
		reset_spank()

func _on_hit_cooldown_timeout() -> void:
	can_spank_timer = true

func _on_hit_timer_timeout() -> void:
	butt_1.modulate = colorInicial

func activar_arma(arma):
	# kept for compatibility; delegate to change_weapon
	change_weapon(arma)


func _apply_damage() -> void:
	var selected = arma_elegida if arma_elegida != null else weapon
	if selected == null:
		push_warning("No weapon selected in _apply_damage")
		return
	var is_game_over = damage_calculator.apply_damage(selected, spank_multi)
	# persist stats to Global every hit so the global state stays in sync
	var amount_dolor = selected.dolor * spank_multi
	var amount_placer = selected.placer * spank_multi
	var amount_tolerancia = selected.tolerancia * spank_multi
	Global.add_dolor(int(amount_dolor))
	Global.add_placer(int(amount_placer))
	Global.reduce_tolerancia(int(amount_tolerancia))

	if is_game_over:
		can_spank_zone = false
		# compute and store final score in Global so the score scene can read it
		Global.score_calculation() 
		# still emit gameOver for other listeners
		Global.gameOver.emit()
		SceneChanger.change_to("res://scenes/score_scene/score_screen.tscn", true)
		return
