extends CanvasLayer

signal start_game

func show_message(text: String):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message('Game Over')
	yield($MessageTimer, 'timeout')
	
	$Message.text = 'Dodge The\nCreepy Squids!'
	$Message.show()
	
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func update_score_label(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal('start_game')
	


func _on_MessageTimer_timeout():
	$Message.hide()
