extends StaticBody2D

onready var camera = get_node("../camera")
onready var player = get_node("../player")

func _ready():
	$anim.play("open")
	
func _process(delta):
	if camera.grid_pos == camera.get_grid_pos(global_position):
		if camera.get_enemies() == 0:
			if $anim.assigned_animation != "open":
				$anim.play("open")
		elif !$area.get_overlapping_bodies().has(player):
			if $anim.assigned_animation != "close":
				$anim.play("close")
	else:
		if $anim.assigned_animation != "open":
				$anim.play("open")
