extends Node3D
class_name Cell

@export var wall_material:StandardMaterial3D
@export var ceiling_material:StandardMaterial3D
@export var floor_material:StandardMaterial3D

@export var walls:Array[MeshInstance3D]

@onready var topFace = $TopTile
@onready var northFace = $NorthTile
@onready var eastFace = $EastTile
@onready var southFace = $SouthTile
@onready var westFace = $WestTile
@onready var bottomFace = $BottomTile

func update_faces(cell_list) -> void:
	@warning_ignore("narrowing_conversion")
	var my_grid_position = Vector2i(position.x/World.GRID_SIZE, position.z/2)
	if cell_list.has(my_grid_position + Vector2i.RIGHT):
		eastFace.queue_free()
	if cell_list.has(my_grid_position + Vector2i.LEFT):
		westFace.queue_free()
	if cell_list.has(my_grid_position + Vector2i.DOWN):
		southFace.queue_free()
	if cell_list.has(my_grid_position + Vector2i.UP):
		northFace.queue_free()
	
	
