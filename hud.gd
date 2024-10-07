extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NextLevelButton.hide()
	$SuccessLabel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("level_one"):
		get_tree().change_scene_to_file("res://level_1.tscn");
	if Input.is_action_pressed("level_two"):
		get_tree().change_scene_to_file("res://level_2.tscn");
	if Input.is_action_pressed("level_three"):
		get_tree().change_scene_to_file("res://level_3.tscn");
	
func level_finished() -> void:
	$NextLevelButton.show();
	$SuccessLabel.show();

func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level_2.tscn");
