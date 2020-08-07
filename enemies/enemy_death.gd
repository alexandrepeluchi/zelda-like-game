extends Node2D

func _ready():
	# Run default death animation
	$anim.play("default")
	# Destroy animation after finished
	$anim.connect("animation_finished", self, "destroy")

# Function to destroy the animation
func destroy(_animation):
	# Delete itself
	queue_free()
