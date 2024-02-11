extends Node2D

const ROW_STEP = 10.0
const SPEED_BOOST := 2.5

@onready var shot_timer := $ShotTimer

var direction := Vector2.RIGHT
var speed := 5.0

func _process(delta: float):
	global_position += direction * speed * delta
	
func change_direction():
	direction *= -1
	global_position.y += ROW_STEP
	Events.enemies_row_changed.emit()
	speed += SPEED_BOOST

func _on_shot_timer_timeout():
	var enemies = get_tree().get_nodes_in_group("enemy")
	if enemies.size() > 0:
		enemies.pick_random().shot()
