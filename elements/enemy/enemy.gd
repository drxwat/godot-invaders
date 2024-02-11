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
	$RayCastLeft.enabled = false
	$RayCastRight.enabled = false
	var rigidbody = RigidBody2D.new()
	rigidbody.add_child(CollisionShape2D.new())
	get_tree().root.add_child(rigidbody)
	rigidbody.global_position = global_position
	reparent(rigidbody, true)
	collision_layer = 0
	collision_mask = 0
	rigidbody.apply_impulse(Vector2(randf_range(-1, 1), randf() * 2) * -100)
	rigidbody.inertia = 1
	rigidbody.apply_torque_impulse(randf() * 10)

func shot():
	var bullet = BULLET_SCENE.instantiate()
	bullet.global_position += global_position + Vector2(0, 10.0)
	get_tree().root.add_child(bullet)

func _on_visible_on_screen_notifier_2d_screen_exited():
	remove_from_group("enemy")
	Events.enemy_died.emit()
	get_parent().queue_free()
