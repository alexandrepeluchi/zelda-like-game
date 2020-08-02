class_name entity extends KinematicBody2D

export(int) var SPEED = 0

var movedir = Vector2(0,0)

# A direção que a sprite vai iniciar
var spritedir = "down"

func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))
	
func spritedir_loop():
	match movedir:
		Vector2(0,-1):
			spritedir = "up"
		Vector2(0,1):
			spritedir = "down"
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
			
func anim_switch(animation):
	var newAnim = str(animation, spritedir)
	if $anim.current_animation != newAnim:
		$anim.play(newAnim)		
