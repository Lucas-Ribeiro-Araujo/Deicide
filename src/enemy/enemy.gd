class_name Enemy extends Node3D

@onready var world:World = get_node("../")
@onready var enemy_sprite:MeshInstance3D = $EnemySprite
@export var idle_texture:AnimatedTexture

var current_grid_position:Vector2i
var target_grid_position:Vector2i = Vector2i.ZERO

var current_path:Array[Vector2i]

func initialize():
	var material:BaseMaterial3D = enemy_sprite.get_active_material(0)
	material.albedo_texture = idle_texture
	
	current_grid_position = Vector2i(position.x, position.z) / World.GRID_SIZE
	
	current_path = world.astar_grid.get_id_path(current_grid_position, world.player.currentGridPosition)
	
	print("Current grid position: %s" % current_grid_position)
	print("First path position: %s" % current_path)

func _process(delta):
	
	
	if current_grid_position != target_grid_position:
		position = lerp(position, Vector3(target_grid_position.x / World.GRID_SIZE,0,target_grid_position.y/ World.GRID_SIZE), 10 * delta)
	pass
