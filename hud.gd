extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$NextLevelButton.hide()
	$SuccessLabel.hide()

var cur_level = 1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("level_one"):
		get_tree().change_scene_to_file("res://main.tscn");
	if Input.is_action_pressed("level_two"):
		get_tree().change_scene_to_file("res://level_2.tscn");
	if Input.is_action_pressed("level_three"):
		get_tree().change_scene_to_file("res://level_3.tscn");
	
func level_finished() -> void:
	$NextLevelButton.show();
	$SuccessLabel.show();

func _on_next_level_button_pressed() -> void:
	if cur_level == 1:
		cur_level = 2
		get_tree().change_scene_to_file("res://level_2.tscn");
	if cur_level == 2:
		get_tree().change_scene_to_file("res://level_3.tscn");
