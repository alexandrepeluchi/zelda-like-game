extends entity

func _physics_process(_delta):
	controls_loops()
	movement_loop()
	spritedir_loop()
	
	if is_on_wall() and movedir != dir.center:
		if spritedir == "up" and test_move(transform, dir.up):
			anim_switch("push")
		if spritedir == "down" and test_move(transform, dir.down):
			anim_switch("push")
		if spritedir == "left" and test_move(transform, dir.left):
			anim_switch("push")
		if spritedir == "right" and test_move(transform, dir.right):
			anim_switch("push")	
	elif movedir != dir.center:
		anim_switch("walk")
	else:
		anim_switch("idle")

func controls_loops():
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	
	movedir.y = - int(UP) + int(DOWN)	
	movedir.x = -int(LEFT) + int(RIGHT)
	
