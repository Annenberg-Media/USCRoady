extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_text(score: int, high_score: int) -> void:
	$GameOverLabel.text = str("Game Over!\nScore: ",score,"\nHigh Score: ",high_score);

func _on_reset_game_button_pressed() -> void:
	get_tree().reload_current_scene()
	hide();
