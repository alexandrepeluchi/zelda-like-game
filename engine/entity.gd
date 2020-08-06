class_name entity extends KinematicBody2D

export(String) var TYPE = "ENEMY" 
export(int) var SPEED = 0

const MAXHEALTH = 2

var movedir = dir.stopped
var knockdir = dir.stopped

# A direção que a sprite vai iniciar
var spritedir = "down"

var hitstun = 0
var health = MAXHEALTH
var texture_default = null
var texture_hurt = null

func _ready():
	texture_default = $Sprite.texture
	texture_hurt = load($Sprite.texture.get_path().replace(".png", "_hurt.png"))

func movement_loop():
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * SPEED
	else:
		motion = knockdir.normalized() * 125
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
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		
		if TYPE == "ENEMY" && health <= 0:
			.queue_free()
		
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		if hitstun == 0 and body.get("DAMAGE") != null and body.get("TYPE") != TYPE:
			health -= body.get("DAMAGE")
			hitstun = 10
			knockdir = global_transform.origin - body.global_transform.origin 
	
func use_item(item):
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)
	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()
		
