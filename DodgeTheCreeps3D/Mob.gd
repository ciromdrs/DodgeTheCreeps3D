extends KinematicBody

var min_speed = 3
var max_speed = 9
var mob_speed = rand_range(min_speed,max_speed)
var target
var mesh
var mob_types = [preload('assets/MobWalk.tscn'),
	preload('assets/MobSwim.tscn'),
	preload('assets/MobFly.tscn')]
	
func _ready():
	mesh = mob_types[randi() % len(mob_types)].instance()
	add_child(mesh)


func _process(delta):
	var eye = mesh.get_node("Eye")
	eye.look_at(target.global_transform.origin, Vector3(0,0,1))
	

func _physics_process(delta):
	var direction = global_transform.basis.y.normalized()
	var collided = move_and_collide(direction * mob_speed * delta)
	if collided:
		collided.collider.game_over()


func _on_Visibility_screen_exited():
	queue_free()


func _on_start_game():
	queue_free()
