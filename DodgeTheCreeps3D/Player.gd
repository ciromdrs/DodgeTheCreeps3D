extends KinematicBody


signal hit


var dodger_speed = 10

func _ready():
	hide()

func _physics_process(delta):
	var velocity = Vector3()
	if Input.is_action_pressed('ui_up'):
		velocity.y += 1
	if Input.is_action_pressed('ui_down'):
		velocity.y -= 1
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	velocity = velocity.normalized() * delta * dodger_speed
	
	var collided = move_and_collide(velocity)
	if collided:
		if collided.collider.is_class("KinematicBody"):
			game_over()
			
	if velocity.length() > 0:
		$Dodger/AnimationPlayer.play()
		var rz = rad2deg(atan2(velocity.y,velocity.x)) - 90
		rotation = Vector3(0,0,deg2rad(rz))
	else:
		$Dodger/AnimationPlayer.stop()
	
	
	

func start(pos):
	translation = pos
	rotation = Vector3()
	show()
	$CollisionShape.disabled = false


func game_over():
	hide()
	emit_signal("hit")
	$CollisionShape.set_deferred("disabled", true)
