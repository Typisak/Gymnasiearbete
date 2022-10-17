extends KinematicBody2D

export (int) var run_speed = 300
export (int) var jump_speed = -350
export (int) var gravity = 800

var velocity = Vector2()
#var jumping = true
#var walking = true

func get_input():
	velocity.x = 0

	if Input.is_action_pressed("jump") and is_on_floor():
		#jumping = true
		velocity.y = jump_speed
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= run_speed
		#walking = true
		#$Sprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		velocity.x += run_speed
		#walking = true
		#$Sprite.flip_h = false
	#else:
		#walking = false

func _physics_process(delta):
	get_input()
	velocity.y += delta * gravity
	
	#if jumping and is_on_floor():
		#jumping = false
	#if walking == false and velocity.x > 0:
	#	velocity.x -= 10
	#elif walking == false and velocity.x < 0:
	#	veloci

	velocity = move_and_slide(velocity, Vector2(0, -1))
