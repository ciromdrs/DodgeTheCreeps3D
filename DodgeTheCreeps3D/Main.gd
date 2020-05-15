extends Spatial

export (PackedScene) var mob_scene

const distance = 12

var score = 0


func _ready():
	randomize()


func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	var pos = rand_pos()
	mob.translation = pos
	var rot = rad2deg(atan2(pos.y,pos.x)) + 90
	rot += rand_range(-25,25)
	mob.rotate_z(deg2rad(rot))
	mob.target = $Player
	add_child(mob)
	$HUD.connect("start_game", mob, "_on_start_game")


func rand_pos():
	var pos = Vector3(rand_range(-1,1), rand_range(-1,1), 0)
	if pos == Vector3():
		pos.y += 1
	return pos.normalized() * distance


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start(Vector3())
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

