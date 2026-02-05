extends Control
class_name DolorBar
@onready var dolor_prograss_bar: ProgressBar = $DolorPrograssBar
#$HealthBar.bind_to(self) # si la barra es hija del enemigo para bindear a la escena



# Opcional: si quieres suavizado visual
@export var smooth := true
@export var smooth_speed := 12.0

# Valores internos
var _target_value: float = 100.0

func _ready() -> void:
	_target_value = dolor_prograss_bar.value

func _process(delta: float) -> void:
	if not smooth:
		return
	# Interpolación suave hacia el valor objetivo
	dolor_prograss_bar.value = move_toward(dolor_prograss_bar.value, _target_value, smooth_speed * delta * dolor_prograss_bar.max_value)

# --- API pública ---

# Conecta esta barra a cualquier nodo que emita la señal:
# signal dolor_changed(current: float, max_dolor: float)
func bind_to(emitter: Object, signal_name: StringName = &"dolor_changed") -> void:
	if emitter == null:
		return

	# Evita conexiones duplicadas
	if emitter.is_connected(signal_name, Callable(self, "_on_value_changed")):
		return

	emitter.connect(signal_name, Callable(self, "_on_value_changed"))

# Puedes llamar esto manualmente si no usas señales
func set_values(current: float, max_v: float) -> void:
	dolor_prograss_bar.max_value = max(1.0, max_v)
	_set_target(clamp(current, 0.0, dolor_prograss_bar.max_value))

# --- Señal esperada ---
# Firma: dolor_changed(current, max_dolor)
func _on_value_changed(current: float, max_dolor: float) -> void:
	set_values(current, max_dolor)

# --- Helpers ---
func _set_target(v: float) -> void:
	_target_value = v
	if not smooth:
		dolor_prograss_bar.value = _target_value
