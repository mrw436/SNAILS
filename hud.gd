extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NextLevelButton.hide()
	$SuccessLabel.hide()

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
func level_finished() -> void:
	$NextLevelButton.show();
	$SuccessLabel.show();

func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level 2.tscn");
