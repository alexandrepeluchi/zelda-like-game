extends CanvasLayer

func _process(_delta):
	$keys.frame = get_node("../player").keys
