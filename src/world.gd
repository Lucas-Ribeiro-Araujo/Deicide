class_name World 
extends Node3D

# cell_light_souls = [0,0]
# cell_dark_souls = [0,1]
const dict_tile_to_cell = {
	Vector2i(0,0): preload("res://scenes/map_creator/tiles/cell_light_souls.tscn"),
	Vector2i(1,0): preload("res://scenes/map_creator/tiles/cell_dark_souls.tscn"),
}

const ENEMY:PackedScene = preload("res://scenes/enemies/enemy.tscn")
const GRID_SIZE:float = 2
const WORLD_SIZE:int = 64

@export var Map:PackedScene

var cells_positions:Array[Vector2i]
var enemies_positions:Array[Vector2i]
var player:Player
var enemies:Array

var astar_grid:AStarGrid2D

func _ready():
	generate_map()
	astar_grid = AStarGrid2D.new()
	astar_grid.size = Vector2i(WORLD_SIZE,WORLD_SIZE)
	astar_grid.cell_size = Vector2.ONE * GRID_SIZE
	astar_grid.diagonal_mode = 1
	astar_grid.update()
	
	for posX in astar_grid.size.x:
		for posY in astar_grid.size.y:
			astar_grid.set_point_solid(Vector2i(posX,posY), true)
	
	for cell in cells_positions:
		astar_grid.set_point_solid(cell, false)
	
	print ("enemies: %s" % enemies.size())
	for enemy in enemies:
		if enemy.has_method("initialize"):
			enemy.initialize()

func generate_map():
	if Map:
		var map = Map.instantiate()
		var tilemap:TileMap = map.get_tilemap()
		
		cells_positions = tilemap.get_used_cells(0)
		enemies_positions = tilemap.get_used_cells(1)
		
		
		for tile in cells_positions:
			var tile_data:TileData = tilemap.get_cell_tile_data(0,Vector2i(tile.x,tile.y))
			var cell_scene:PackedScene = dict_tile_to_cell.get(tile_data.texture_origin)
			var cell = cell_scene.instantiate()
			
			add_child(cell)
			cell.position = Vector3(tile.x * GRID_SIZE, 0, tile.y * GRID_SIZE)
			cell.update_faces(cells_positions)
		
		for tile in enemies_positions:
			var enemy = ENEMY.instantiate()
			add_child(enemy)
			enemies.append(enemy)
			enemy.position =  Vector3(tile.x * GRID_SIZE, 0, tile.y * GRID_SIZE)
		
		map.free()

func has_tile(pos:Vector2i) -> bool:
	return cells_positions.has(pos)
