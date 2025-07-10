extends CharacterBody2D

var SPEED = 15.0
const JUMP_VELOCITY = -40.0
@onready var animation : AnimatedSprite2D = $animation

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animation.play("walk")
		animation.scale.x = direction/2
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")

	move_and_slide()

func set_anim1():
	animation = $"animation-1"
	$animation.hide()
	$"animation-1".show()
	
func set_anim2():
	animation = $"animation-2"
	$"animation-1".hide()
	$"animation-2".show()
	
func set_anim3():
	animation = $"animation-3"
	$"animation-2".hide()
	$"animation-3".show()
