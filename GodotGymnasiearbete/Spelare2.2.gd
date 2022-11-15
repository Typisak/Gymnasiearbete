extends KinematicBody2D

signal grounded_update(grounded)

const UP_DIRECTION = Vector2.UP #Kan ändras för att gå på väggar etc.

export var speed = 250 #Karaktärens gånghastighet

export var gravity = 600 #Gravitationens styrka
export var jump_quantity = 1 #Antalet hopp karaktären kan göra
export var jump_strength = 300 #Första hoppets styrka
export var jump2_strength = 250 #Andra hoppets styrka
#Fler styrkor för andra hopp läggs till här

#Variabler för karaktärens tillstånd
var walking = false
var jumping = false
var falling = false
var double_jumping = false
#var jump_cancellation = false
var idle = false
var grounded

var jumps_total = 0 #Räknare för antalet hopp gjorda
var velocity = Vector2.ZERO #Rörelsevektorn

func character_state():
	#TRUE om karaktären går
	walking = is_on_floor() and not is_zero_approx(velocity.x)
	#TRUE om karaktären hoppar
	jumping = Input.is_action_pressed("jump") and is_on_floor()
	#TRUE om karaktären faller
	falling = velocity.y > 0 and not is_on_floor()
	#TRUE om karaktären dubbelhoppar (Baserat på om den faller och hoppar)
	double_jumping = Input.is_action_just_pressed("jump") and falling
	#TRUE om ett hopp förhindras
	#var jump_cancellation = Input.is_action_just_released("jump") and velocity.y < 0
	#TRUE om karaktären är stilla/idle
	idle = is_on_floor() and is_zero_approx(velocity.x)

#func animation(): #AVKOMMENTERAS NÄR ANIMATIONER SKAPATS
	#LÄGG TILL SPRITE FLIP
	#SPELA UPP ANIMATION BASERAT PÅ TILLSTÅND
	#Animerar karaktärens hopp
	#if jumping or double_jumping:
	#	(Animationsmetod)
	#Animerar karaktärens gång
	#if walking:
	#	(Animationsmetod)
	#Animerar karaktärens fall
	#if falling:
	#	(Animationsmetod)
	#Animerar Karaktärens stillastånd
	#if idle:
	#	(Animationsmetod)

func _physics_process(delta):
	var walk_direction = (
		Input.get_action_strength("move_right")
		-Input.get_action_strength("move_left")
	)
	velocity.x = walk_direction * speed
	velocity.y += gravity * delta
	
	character_state() #Kallar på funktionen character_state
	
	if jumping:
		velocity.y = -jump_strength 
		jumps_total += 1
	#elif double_jumping:
	#	if jumps_total < jump_quantity:
	#		velocity.y = -jump2_strength
	#		jumps_total += 1
	elif idle or walking:
		jumps_total = 0
	
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
	var was_grounded = grounded
	grounded = is_on_floor()
	
	if was_grounded == null || grounded != was_grounded:
		emit_signal("grounded_update", grounded)
	
	#animation()
