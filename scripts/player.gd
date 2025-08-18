extends CharacterBody2D

var SPEED = 20.0
var RUN_SPEED = 50.0
const JUMP_VELOCITY = -150.0
const GRAVITY = 1200.0
const FALL_MULTIPLIER = 0.8  # reduz a gravidade enquanto sobe

@onready var animation : AnimatedSprite2D = $animation

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Gravidade variável (subindo mais devagar)
	if not is_on_floor():
		if velocity.y < 0:  # subindo
			velocity.y += GRAVITY * 0.3 * delta  # sobe bem devagar
		else:  # caindo
			velocity.y += GRAVITY * 0.5 * delta

	# Pulo
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var current_speed = SPEED
	if Input.is_action_pressed("run"):
		current_speed = RUN_SPEED

	# Direção horizontal
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = direction * current_speed
		animation.play("walk")  # sempre walk quando houver movimento
		animation.scale.x = direction / 2
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.play("idle")

	move_and_slide()

# Troca de animações extras
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
