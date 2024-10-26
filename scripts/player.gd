extends CharacterBody2D

# speed in pixels/sec
var speed = 500 

const MOVE_SPEED = 64

var score = 0;
var below = 0;

func getScore():
	return score;

func _physics_process(_delta):
	
	var cameraBottom = get_node("Camera2D").get_screen_center_position().y + 640;

	if Input.is_action_just_pressed("ui_right"):

		position.x += MOVE_SPEED;

	elif Input.is_action_just_pressed("ui_left"):

		position.x -= MOVE_SPEED;

	elif Input.is_action_just_pressed("ui_up"):

		position.y -= MOVE_SPEED;
		if below == 0:
			score += 1;
			get_parent().get_node("HUD").update_score(score)
		else:
			below -= 1;

	elif Input.is_action_just_pressed("ui_down"):
		position.y += MOVE_SPEED;
		below += 1;
	

	if position.y > -64 + cameraBottom:
		position.y = -64 + cameraBottom;
	
	position.x = clamp(position.x, -320, 320);
