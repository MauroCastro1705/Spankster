extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

func _ready() -> void:
	animation_player.play("latido")
	timer.start()
	
	


func _on_timer_timeout() -> void:
	queue_free()
