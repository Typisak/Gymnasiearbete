extends KinematicBody2D

export var speed = 25
var wait = false
var direction = true
var velocity = Vector2(speed/2, 0) #Rörelsevektorn, Hastighet åt höger i början.
#Halva hastighet: placeras centrerat på banan och åker lika långt åt båda håll efteråt

func _ready():
	$AnimatedSprite.playing = true

func _physics_process(_delta):
	velocity = move_and_slide(velocity)


func _on_Timer_timeout():
	velocity.x = 0
	$Wait.start()
	$Timer.paused = true

func _on_Wait_timeout():
	if direction:
		$AnimatedSprite.flip_h = true
		if wait:
			velocity.x = -speed
			direction = false
			wait = false
			$Timer.paused = false
		else:
			wait()
	else:
		$AnimatedSprite.flip_h = false
		if wait:
			velocity.x = speed
			direction = true
			wait = false
			$Timer.paused = false
		else:
			wait()

func wait():
	$Wait.start()
	wait = true

func be_bounced_upon(bouncer):
	if bouncer.has_method("bounce"):
		bouncer.bounce()
		queue_free()
