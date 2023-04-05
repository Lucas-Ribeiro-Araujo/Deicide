class_name Player
extends Node3D

@export var world:World 

var targetPosition:Vector3
var targetRotation:Vector3

var currentGridPosition:Vector2i = Vector2i.ZERO

func _ready():
#	position = Vector3(World.GRID_SIZE/2, 0 , World.GRID_SIZE/2)
#	targetPosition = Vector3(World.GRID_SIZE/2, 0 , World.GRID_SIZE/2)
	currentGridPosition = Vector2i(targetPosition.x, targetPosition.z) / World.GRID_SIZE

func  _process(delta) -> void:
	if position != targetPosition:
		position = lerp(position, targetPosition, 10 * delta)
	
	if rotation != targetRotation:
		rotation = lerp(rotation, targetRotation, 10 * delta)

func _unhandled_input(event) -> void:
	var direction:Vector2 = Vector2.ZERO
	
	if event.is_action_pressed("turn_left"):
		targetRotation = targetRotation + Vector3(0, 0.5 * PI ,0)
	elif event.is_action_pressed("turn_right"):
		targetRotation = targetRotation + Vector3(0,-0.5 * PI,0)
	
	if event.is_action_pressed("forward"):
		direction += Vector2(0,-1)
	if event.is_action_pressed("strafe_left"):
		direction += Vector2(-1,0)
	if event.is_action_pressed("strafe_right"):
		direction += Vector2(1,0)
	if event.is_action_pressed("backward"):
		direction += Vector2(0,1)
	
	direction = direction.rotated(-targetRotation.y)
	
	var gridDirection = Vector2i(direction.x, direction.y)
	
	if gridDirection != Vector2i.ZERO and world.has_tile(currentGridPosition + gridDirection):
		targetPosition = targetPosition + (Vector3(gridDirection.x, 0, gridDirection.y) * World.GRID_SIZE)
		currentGridPosition = Vector2i(targetPosition.x, targetPosition.z) / World.GRID_SIZE

func move_player(direction:Vector2i, rotation:float) -> void:
	pass
