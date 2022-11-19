extends KinematicBody2D

signal grounded_update(grounded)
signal health_updated(health)
signal death()
signal respawn()

const UP_DIRECTION = Vector2.UP #Kan ändras för att gå på väggar etc.
const BOUNCE_VELOCITY = -500

export var speed = 250 #Karaktärens gånghastighet
export var gravity = 1000 #Gravitationens styrka
export var jump_quantity = 2 #Antalet hopp karaktären kan göra
export var jump_strength = 400 #Första hoppets styrka
export var jump2_strength = 300 #Andra hoppets styrka
export var acceleration = 13
#Fler styrkor för andra hopp läggs till här
export var max_health = 3

onready var health = max_health setget set_health
onready var invulnerability = $Invulnerability
onready var effects_damage = $DamageAndInvAnimation
onready var bounce_raycasts = $BounceRayCasts

#Variabler för karaktärens tillstånd
var walking = false
var jumping = false
var falling = false
var double_jumping = false
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
	double_jumping = Input.is_action_just_pressed("jump") and jumps_total > 0 and global_position.x > 0
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

func grounded():
	var was_grounded = grounded
	grounded = is_on_floor()
	if was_grounded == null || grounded != was_grounded:
		emit_signal("grounded_update", grounded)

func set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health) #minimi och maximivärd för returnering
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("death")

func damage(amount):
	if invulnerability.is_stopped():
		invulnerability.start()
		set_health(health - amount)
		effects_damage.play("damage")
		effects_damage.queue("invulnerable")

func kill():
	print("Du har dött")
	emit_signal("death")
	get_tree().paused = true
	$Reset.start()

func _on_Invulnerability_timeout():
	 effects_damage.play("rest")

func _on_Reset_timeout():
	get_tree().paused = false
	emit_signal("respawn")
	get_tree().reload_current_scene()

func check_bounce(delta):
	if falling:
		for raycast in bounce_raycasts.get_children():
			raycast.cast_to = Vector2.DOWN * velocity * delta + Vector2.DOWN
			raycast.force_raycast_update()
			if raycast.is_colliding() and raycast.get_collision_normal() == Vector2.UP:
				velocity.y = (raycast.get_collision_point() - raycast.global_position - Vector2.DOWN).y / delta
				raycast.get_collider().entity.call_deferred("be_bounced_upon", self)
				break

func bounce(bounce_velocity = BOUNCE_VELOCITY):
	velocity.y = bounce_velocity

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		velocity.x = min((velocity.x + acceleration), speed)
	elif Input.is_action_pressed("move_left"):
		velocity.x = max(velocity.x - acceleration, -speed)
	else:
		velocity.x = lerp(velocity.x, 0, 0.15)
	velocity.y += gravity * delta
	
	character_state() #Kallar på funktionen character_state
	
	if jumping:
		velocity.y = -jump_strength 
		jumps_total += 1
	elif double_jumping:
		if jumps_total < jump_quantity:
			velocity.y = -jump2_strength
			jumps_total += 1
	elif idle or walking:
		jumps_total = 0
	
	check_bounce(delta)
	velocity = move_and_slide(velocity, UP_DIRECTION, true)
	
	grounded()
	
	#animation()

func _on_HitscannerEnemy_area_entered(area):
	damage(1)

func _on_HitscannerSpikes_area_entered(area):
	damage(3)



