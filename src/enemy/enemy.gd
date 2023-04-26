class_name Enemy extends Node3D

@onready var world:World = get_node("../")
@onready var enemy_sprite:MeshInstance3D = $EnemySprite
@export var idle_texture:AnimatedTexture

var current_grid_position:Vector2i
var target_grid_position:Vector2i = Vector2i.ZERO

var current_path:Array[Vector2i]

func initialize():
	MusicManager.music_beat.connect(_on_music_beat)
	
	var material:BaseMaterial3D = enemy_sprite.get_active_material(0)
	material.albedo_texture = idle_texture
	
	@warning_ignore("narrowing_conversion")
	current_grid_position = Vector2i(position.x, position.z) / World.GRID_SIZE
	current_path = world.astar_grid.get_id_path(current_grid_position, world.player.currentGridPosition)
	
#	for pos in current_path:
#		print(pos)
	
#	print("Current grid position: %s" % current_grid_position)
#	print("First path position: %s" % current_path)

func _process(delta):
	if current_path:
		if current_grid_position != target_grid_position:
			position = lerp(position, Vector3(target_grid_position.x / World.GRID_SIZE,0,target_grid_position.y/ World.GRID_SIZE), 10 * delta)
	pass

func _on_music_beat():
	current_grid_position = target_grid_position
	current_path = world.astar_grid.get_id_path(current_grid_position, world.player.currentGridPosition)
	if current_path.size() > 1:
		target_grid_position = current_path[1] * World.GRID_SIZE
	for pos in current_path:
		print(target_grid_position)
