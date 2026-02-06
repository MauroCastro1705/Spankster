extends Node
var spank_timer:float = 1.0
signal gameOver

var placer:float = 0
var placer_max:float = 100

var dolor:float = 0
var dolor_max:float = 100

var tolerancia:float = 100 #va disminuyendo
var tolerancia_max:float = 100

var player_score:float = 0

func score_calculation():
	print("---game over----")
	player_score = placer + dolor
	print(player_score)
	
	
func _ready() -> void:
	gameOver.connect(score_calculation)
