class_name Enemy 
extends Node3D

@onready var world:World = get_node("/root/Main/World")
@onready var enemy_sprite:MeshInstance3D = $Sprite
@onready var move_sound:AudioStreamPlayer3D = $MoveSound
@export var idle_texture:AnimatedTexture

var current_grid_position:Vector2i
var target_grid_position:Vector2i = Vector2i.ZERO
var current_path:Array[Vector2i]
var aggro:bool = false

func initialize():
	var material:BaseMaterial3D = enemy_sprite.get_active_material(0)
	
	MusicManager.music_beat.connect(_on_music_beat)
	
	material.albedo_texture = idle_texture
	current_grid_position = Vector2i(position.x, position.z) / World.GRID_SIZE
	target_grid_position = current_grid_position
	current_path = world.astar_grid.get_id_path(current_grid_position, world.player.currentGridPosition)

func _process(delta):
	if current_path != null:
		if current_grid_position != target_grid_position:
			position = lerp(position, Vector3(target_grid_position.x * World.GRID_SIZE,0,target_grid_position.y * World.GRID_SIZE), 10 * delta)
	pass

func _on_music_beat():
	if !aggro:
		return
	
	current_grid_position = target_grid_position
	current_path = world.astar_grid.get_id_path(current_grid_position, world.player.currentGridPosition)
	if current_path.size() > 2:
		target_grid_position = current_path[1]
		move_sound.play()
		world.update_tile(target_grid_position, true)
	
	for pos in current_path:
		pass

func _on_vision_player_on_sight_changed(value):
	aggro = value
	print(value)
