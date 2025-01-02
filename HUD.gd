extends CanvasLayer

@onready var score: Label = $ScoreLabel
@onready var gameOver: Label = $GameOverLabel

func update_score(newScore):
	score.text = str(newScore)

func game_over():
	gameOver.visible = true