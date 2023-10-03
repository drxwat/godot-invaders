extends CanvasLayer

@onready var points_label = $MarginContainer/VBoxContainer/HBoxContainer/Label

func _ready():
	Events.points_changed.connect(update_points)

func update_points(points: int):
	points_label.text = str(points)
