class_name Minimap extends Panel


@onready var grid:GridContainer = $Grid
@export var tile_template:PackedScene

@export var world:World

var tiles:Array[Vector2i]

func _ready():
	for x in World.WORLD_SIZE:
		for y in World.WORLD_SIZE:
			var new_tile = tile_template.instantiate()
			var color_rect:ColorRect = new_tile
			if world.cells_positions.has(Vector2i(x,y)):
				print("i exist")
				color_rect.color = Color.DARK_RED
			grid.add_child(new_tile)
