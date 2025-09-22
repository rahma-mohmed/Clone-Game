extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var anim = $AnimationPlayer
var is_dead = false

#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_dead:
		return 
	if not is_on_floor():
		velocity += get_gravity() * delta
		#die()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("raise")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
		
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")
			
	if velocity.y > 0:
		anim.play("fall")

	move_and_slide()
	
func die():
	is_dead = true
	velocity = Vector2.ZERO
	anim.play("death")
	await anim.animation_finished
	get_tree().reload_current_scene()
	Game.player_hp = 3
