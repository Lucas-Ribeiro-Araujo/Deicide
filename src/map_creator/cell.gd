extends Node3D
class_name Cell

@export var wall_material:StandardMaterial3D
@export var ceiling_material:StandardMaterial3D
@export var floor_material:StandardMaterial3D

#@export var ceiling
#@export var floor
#@export var walls:Array

@onready var topFace = $BottomCollisionShape
@onready var northFace = $NorthCollisionShape
@onready var eastFace = $EastCollisionShape
@onready var southFace = $SouthCollisionShape
@onready var westFace = $WestCollisionShape
@onready var bottomFace = $BottomCollisionShape

func update_faces(cell_list) -> void:
	var my_grid_position = Vector2i(position.x/World.GRID_SIZE, position.z/2)
	
	if cell_list.has(my_grid_position + Vector2i.RIGHT):
		eastFace.queue_free()
	if cell_list.has(my_grid_position + Vector2i.LEFT):
		westFace.queue_free()
	if cell_list.has(my_grid_position + Vector2i.DOWN):
		southFace.queue_free()
	if cell_list.has(my_grid_position + Vector2i.UP):
		northFace.queue_free()
