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
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * SPEED * 1.5
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
	
func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()
		
