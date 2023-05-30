class_name EnemyVision
extends RayCast3D

@onready var enemy:Enemy = get_node("../")

var player_on_sight:bool = false
signal player_on_sight_changed(value:bool)

func _physics_process(delta):
	target_position = enemy.world.player.position - enemy.position
	if player_on_sight == (get_collider() != null):
		player_on_sight = !player_on_sight
		player_on_sight_changed.emit(player_on_sight)
