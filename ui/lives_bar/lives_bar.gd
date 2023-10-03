extends HBoxContainer

var RECT_SCENE = preload("res://ui/lives_bar/live_rect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.lives_changed.connect(update_lives)
	update_lives(Globals.lives)

func update_lives(lives: int):
	if lives < 0:
		return
	var diff = lives - get_child_count()
	for i in range(abs(diff)):
		add_live() if diff > 0 else remove_live()

func add_live():
	add_child(RECT_SCENE.instantiate())

func remove_live():
	get_child(0).queue_free()
