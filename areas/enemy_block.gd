extends TileMap

var block = preload("res://tiles/block.tscn")

func _ready():
	var block_tile = get_used_cells_by_id(0)
	for tile in block_tile:
		var block_instance = block.instance()
		block_instance.global_position = map_to_world(tile) + cell_size / 2
		add_child(block_instance)
