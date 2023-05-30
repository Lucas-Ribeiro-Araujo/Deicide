class_name Minimap extends Panel

@onready var world:World = get_node("/root/Main/World")

@onready var grid:GridContainer = $Grid
@export var tile_template:PackedScene

var minimap_tiles = {}

var tiles:Array[Vector2i]

func _ready():
	world.grid_changed.connect(_on_world_grid_changed)
	_generate_map()


func _on_world_grid_changed(new_grid):
	_generate_map()

func _generate_map():
	for tile in grid.get_children():
		print(tile)
		grid.remove_child(tile)
		tile.queue_free()
	
	for x in World.WORLD_SIZE:
		for y in World.WORLD_SIZE:
			var new_tile = tile_template.instantiate()
			var color_rect:ColorRect = new_tile
			grid.add_child(new_tile)
			if !world.astar_grid.is_point_solid(Vector2i(x,y)):
				color_rect.color = Color.DARK_RED
