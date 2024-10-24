extends CharacterBody2D

# speed in pixels/sec
var speed = 500 

const MOVE_SPEED = 64



func _physics_process(_delta):
	
	var cameraBottom = get_node("Camera2D").get_screen_center_position().y + 640;

	if Input.is_action_just_pressed("ui_right"):

		position.x += MOVE_SPEED

	elif Input.is_action_just_pressed("ui_left"):

		position.x -= MOVE_SPEED

	elif Input.is_action_just_pressed("ui_up"):

		position.y -= MOVE_SPEED

	elif Input.is_action_just_pressed("ui_down"):

		position.y += MOVE_SPEED
	

	if position.y > -64 + cameraBottom:
		position.y = -64 + cameraBottom;
	
	position.x = clamp(position.x, -320, 320);
