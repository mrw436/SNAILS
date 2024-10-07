extends CharacterBody2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

var is_moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!is_moving):
		is_moving = true
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		elif Input.is_action_pressed("move_left"):
			velocity.x -= 1
		elif Input.is_action_pressed("move_down"):
			velocity.y += 1
		elif Input.is_action_pressed("move_up"):
			velocity.y -= 1
		else:
			is_moving = false

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	var collision = move_and_collide(velocity * delta)
	if collision:
		print("I collided with ", collision.get_collider().name)
		is_moving = false
		velocity = Vector2(0,0);
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	# This is where the up/down sprite logic would usually go if we had one
		
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func stop_movement():
	print('movement stopped')
	is_moving = false
	velocity = Vector2.ZERO

func _on_body_entered(_body: Node2D) -> void:
	print('on body entered')
	stop_movement()
	hit.emit()
