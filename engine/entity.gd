class_name entity extends KinematicBody2D

export(int) var SPEED = 0

var movedir = dir.center

# A direção que a sprite vai iniciar
var spritedir = "down"

func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, dir.center)
	
func spritedir_loop():
	match movedir:
		dir.up:
			spritedir = "up"
		dir.down:
			spritedir = "down"
		dir.left:
			spritedir = "left"
		dir.right:
			spritedir = "right"
			
func anim_switch(animation):
	var newAnim = str(animation, spritedir)
	if $anim.current_animation != newAnim:
		$anim.play(newAnim)		
