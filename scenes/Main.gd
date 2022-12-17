extends Node

export (PackedScene) var mob_scene: PackedScene
var score: int

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$HUD.update_score_label(score)
	$HUD.show_message('Get Ready!')
	get_tree().call_group('mobs', 'queue_free')
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$Music.play()

func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	
	# set random location in Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.offset = randi()
	
	# set mob position to be perpendicular to path
	var direction = mob_spawn_location.rotation + PI / 2
	
	# set mob position to random position
	mob.position = mob_spawn_location.position
	
	# add randomness to mob rotation (direction)
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# set random mob velocity
	var velocity = Vector2(rand_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score_label(score)


func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()
