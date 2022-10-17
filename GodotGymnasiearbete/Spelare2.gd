extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 50 # Spelarens hastighet i pixlar per sekund. Export tillåter redigering av variabelvärdet i inspektören.
var screen_size # Storleken av spelfönstret
const gravity = 300.0 #Variabel för gravitationsmängden

var velocity = Vector2() # The player's movement vector.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size



# Kallas vid varje frame (_process). delta är den tid som gått sedan senaste framen
func _physics_process(delta):
	velocity.x = velocity.x - 10
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -150
		#velocity.y = -2000
		#Lägg till hoppfunktion
		
	if Input.is_action_pressed("crouch"):
		#velocity.y += 1
		#Lägg till omformning av sprite och collision
		pass
	#move_and_collide(Vector2(0, 1)) # Move down 1 pixel per physics frame
	
	velocity.y += velocity.y + (delta * gravity)
	
	move_and_slide(velocity)
	
	velocity = move_and_slide(velocity, Vector2(0, -1)).normalized() * speed


	#velocity = velocity.normalized() * speed
		#$AnimatedSprite.play()
	#else:
		#$AnimatedSprite.stop()
		
		
	#if velocity.x != 0:
		#$AnimatedSprite.animation = "walk"
		#$AnimatedSprite.flip_v = false
		#$AnimatedSprite.flip_h = velocity.x < 0 #Vänder på animationen när karaktären rör sig bakåt
		
	#elif velocity.y != 0:
		#$AnimatedSprite.animation = "jump"
		#$AnimatedSprite.flip_v = velocity.y > 0
		
		
	position += velocity * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
