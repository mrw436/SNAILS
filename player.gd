extends Area2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func reset_movement_after_seconds(seconds: int):
	await get_tree().create_timer(seconds).timeout # Wait for x seconds
	velocity = Vector2.ZERO
	is_moving = false

var velocity = Vector2.ZERO # The player's movement vector.
var is_moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!is_moving):
		is_moving = true
		if Input.is_action_pressed("move_right"):
			reset_movement_after_seconds(2)
			velocity.x += 1
		elif Input.is_action_pressed("move_left"):
			reset_movement_after_seconds(2)
			velocity.x -= 1
		elif Input.is_action_pressed("move_down"):
			reset_movement_after_seconds(2)
			velocity.y += 1
		elif Input.is_action_pressed("move_up"):
			reset_movement_after_seconds(2)
			velocity.y -= 1
		else:
			is_moving = false
	#if !(Input.is_action_pressed("move_right") || Input.is_action_pressed("move_up") || Input.is_action_pressed("move_left") || Input.is_action_pressed("move_down")):
		#velocity = Vector2.ZERO # The player's movement vector.
	#reset_movement_after_seconds(2)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	# This is where the up/down sprite logic would usually go if we had one
		
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
