extends CharacterBody2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

var tilemap # Reference to your TileMap
var water_tile_id = 3 # ID for water tile in the TileSet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	tilemap = get_node("../TileMapLayer") # Get the TileMap node (adjust the path)

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
		#print(collision.get_collider())
		var tile_pos = tilemap.get_coords_for_body_rid(collision.get_collider_rid())
		var tile_id = tilemap.get_cell_tile_data(tile_pos).get_terrain() # Get the tile ID at the player's position
		#print("I collided with ", tile_id)
		# tile_id 2 is water
		if tile_id == 2:
			kill_snail()
		is_moving = false
		velocity = Vector2(0,0);
	
	if velocity.x != 0:
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0
	# This is where the up/down sprite logic would usually go if we had one
		
		
func kill_snail():
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
