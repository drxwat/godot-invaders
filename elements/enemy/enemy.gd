extends CharacterBody2D

const BULLET_SCENE = preload("res://elements/enemy_bullet/enemy_bullet.tscn")

@onready var raycast_left := $RayCastLeft
@onready var raycast_right := $RayCastRight

var direction_changed := false

func _physics_process(delta):
	if not direction_changed:
		if raycast_left.is_colliding() or raycast_right.is_colliding():
			get_tree().get_first_node_in_group("enemy_group").change_direction()
			direction_changed = true
	if not raycast_left.is_colliding() and not raycast_right.is_colliding():
		direction_changed = false

func destroy():
	Globals.change_points(1)
	Events.enemy_died.emit()
	queue_free()

func shot():
	var bullet = BULLET_SCENE.instantiate()
	bullet.global_position += global_position + Vector2(0, 10.0)
	get_tree().root.add_child(bullet)
