extends CharacterBody2D

var speed = 80
var gravity = 19
var player
var chase = false

func _ready():
	$AnimatedSprite2D.play("Ideal")
	
func _physics_process(delta):
	velocity.y += gravity
	if chase == true:
		if $AnimatedSprite2D.animation != "Death":
			$AnimatedSprite2D.play("Run")
			
		player = get_node("../../Player")
		var dir = (player.position - self.position) 
		if dir.x > 0:
			$AnimatedSprite2D.flip_h = true
			velocity.x = speed
		if dir.x < 0:
			$AnimatedSprite2D.flip_h = false
			velocity.x = -1*speed
	else:
		if $AnimatedSprite2D.animation != "Death":
			$AnimatedSprite2D.play("Ideal")
		velocity.x = 0
	move_and_slide()
		

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_hard_area_body_entered(body):
	if body.name == "Player":
		Game.player_hp -= 1
		if Game.player_hp == 0:
			print(Game.player_hp)
			body.die()


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_enemy_death_body_entered(body):
	if body.name == "Player":
		death()
		
		
func death():
	chase = false
	velocity.x = 0
	$AnimatedSprite2D.play("Death")
	$EnemyDeathAudio.play()
	await  $AnimatedSprite2D.animation_finished
	self.queue_free()
