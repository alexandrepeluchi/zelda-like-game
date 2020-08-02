class_name entity extends KinematicBody2D

export(String) var TYPE = "ENEMY" 
export(int) var SPEED = 0

var movedir = dir.stopped
var knockdir = dir.stopped

# A direção que a sprite vai iniciar
var spritedir = "down"

var hitstun = 0
var health = 1

func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, dir.stopped)
	
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
		
func damage_loop():
	if hitstun > 0:
		hitstun -= 1
	for body in $hitbox.get_overlapping_bodies():
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = transform.origin - body.transform.origin
	
