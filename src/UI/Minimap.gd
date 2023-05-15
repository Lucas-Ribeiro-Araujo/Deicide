class_name Minimap extends Panel


@onready var grid:GridContainer = $Grid
@export var tile_template:PackedScene

var tiles:Array[Vector2i]

func _ready():
	for x in World.WORLD_SIZE:
		for y in World.WORLD_SIZE:
			var new_tile = tile_template.instantiate()
			var color_rect:ColorRect = new_tile
			grid.add_child(new_tile)
