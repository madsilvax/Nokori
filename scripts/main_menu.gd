extends Control

@onready var fade: ColorRect = $Fade
@onready var motion = $logo_anim

func _ready():
	
	motion.play("logo_motion")
	
	if not is_instance_valid(fade):
		_create_fade()
	
	fade.color = Color(0, 0, 0, 1)  
	fade.visible = true
	_fade_in()

func _create_fade():
	fade = ColorRect.new()
	fade.name = "Fade"
	fade.color = Color(0, 0, 0, 1)
	fade.anchor_right = 1.0
	fade.anchor_bottom = 1.0
	fade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(fade)
	move_child(fade, get_child_count())  

func _fade_in():
	var tween = create_tween().set_parallel(false)
	tween.tween_property(fade, "color:a", 0.0, 2.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func(): fade.visible = false)

func _fade_out(target_scene: String = ""):
	print("Iniciando fade out - Alpha atual: ", fade.color.a)
	fade.visible = true
	fade.color.a = 0.0  
	
	var tween = create_tween().set_parallel(false)
	tween.tween_property(fade, "color:a", 1.0, 2.0)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	
	if target_scene:
		tween.tween_callback(func(): 
			print("Mudando para cena: ", target_scene)
			get_tree().change_scene_to_file(target_scene)
		)
	else:
		tween.tween_callback(func():
			print("Saindo do jogo")
			get_tree().quit()
		)

func _on_iniciar_pressed():
	print("Botão Iniciar - Pré-fade")
	_fade_out("res://scenes/game.tscn")

func _on_sair_do_jogo_pressed():
	print("Botão Sair - Pré-fade")
	_fade_out()
