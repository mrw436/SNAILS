extends Area2D

signal finish_level
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play();

func _on_body_entered(_body: Node2D) -> void:
	print("emitting finish level")
	finish_level.emit();
