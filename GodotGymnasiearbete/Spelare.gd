extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 16 # Spelarens hastighet i pixlar per sekund. Export tillåter redigering av variabelvärdet i inspektören.
var screen_size # Storleken av spelfönstret


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Kallas vid varje frame (_process). delta är den tid som gått sedan senaste framen
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("jump"):
		velocity.y -= 1
	if Input.is_action_pressed("crouch"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0 #Vänder på animationen när karaktären rör sig bakåt
	elif velocity.y != 0:
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.flip_v = velocity.y > 0
		
	position += velocity * delta

