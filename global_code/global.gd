extends Node
var spank_timer:float = 1.0
signal gameOver

var placer:int = 0
var placer_max:int = 100

var dolor:int = 0
var dolor_max:int = 100

var tolerancia:int = 100 #va disminuyendo
var tolerancia_max:int = 100

var player_score:int = 0

func score_calculation():
	print("---game over----")
	player_score = placer + dolor
	print(player_score)
	
	
func _ready() -> void:
	gameOver.connect(score_calculation)
