extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var texture_rect: TextureRect = $TextureRect
@export var min_scale := 0.9
@export var max_scale := 1.3

func _ready() -> void:
	randomize() # or use RandomNumberGenerator (see option B)
	var s := randf_range(min_scale, max_scale)
	texture_rect.scale = Vector2(s, s)

	animation_player.play("latido")
	timer.start()


func _on_timer_timeout() -> void:
	queue_free()
