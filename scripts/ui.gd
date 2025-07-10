extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$PAUSE/control_pause.show()
		get_tree().paused = true

func _on_continuar_pressed() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$PAUSE/control_pause.hide()
	get_tree().paused = false

func _on_recomeçar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_principal_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_sair_do_jogo_pressed() -> void:
	get_tree().quit()

func initial_quote():
	$"QUOTE/control initital quote".show()
	await get_tree().create_timer(6).timeout
	$"QUOTE/control initital quote".hide()

func final_quote():
	$"QUOTE/control final quote".show()
	await get_tree().create_timer(10).timeout
	$"QUOTE/control final quote".hide()

func credits():
	$CREDITS/control_credits.show()
	$CREDITS/control_credits/VideoStreamPlayer.play()

func gameover():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$GAMEOVER/control_gameover.show()
	get_tree().paused = true
