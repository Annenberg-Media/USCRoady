extends CharacterBody2D

var step_size = 64
var move_speed = 500  
var target_position = Vector2()
var moving = false

# Screen limits? 
var screen_limits = Rect2(Vector2(0, 0), Vector2(1024, 768))

func _ready():
	target_position = position

func _process(delta):
	if not moving:
		if Input.is_action_just_pressed("ui_up"):
			if position.y - step_size >= screen_limits.position.y:
				target_position.y -= step_size
				moving = true
		elif Input.is_action_just_pressed("ui_down"):
			if position.y + step_size < screen_limits.position.y + screen_limits.size.y:
				target_position.y += step_size
				moving = true
		elif Input.is_action_just_pressed("ui_left"):
			if position.x - step_size >= screen_limits.position.x:
				target_position.x -= step_size
				moving = true
		elif Input.is_action_just_pressed("ui_right"):
			if position.x + step_size < screen_limits.position.x + screen_limits.size.x:
				target_position.x += step_size
				moving = true

	if moving:
		position = position.move_toward(target_position, move_speed * delta)

		if position.distance_to(target_position) < 1:
			position = target_position
			moving = false

	if position == target_position and not moving:
		reset_target_position()

func reset_target_position():
	target_position.x = clamp(target_position.x, screen_limits.position.x, screen_limits.position.x + screen_limits.size.x)
	target_position.y = clamp(target_position.y, screen_limits.position.y, screen_limits.position.y + screen_limits.size.y)
