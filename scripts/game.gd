extends Node2D

var player_entered = false
var hikari_stage = false
var yume_stage = false
var haruka_stage = false
var nozomi_stage = false

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var ui: Control = $player/UI

func _ready() -> void:
	get_tree().paused = true
	ui.sound_quote()
	await get_tree().create_timer(6).timeout
	ui.initial_quote()
	await get_tree().create_timer(6).timeout
	get_tree().paused = false

func _input(event):
	if Input.is_action_just_pressed("action"):
		if hikari_stage == true:
			get_node("/root/game/player").set_anim1()
			$"npc's/hikari/hikari_area/CollisionShape2D".queue_free()
			$player/luz.play()
			$player/sora_fx.play()
			await get_tree().create_timer(0.5).timeout
			$player/Light/PointLight2D_5.hide()
			$player/Light/PointLight2D_4.show()
			$"npc's/hikari/light".show()
			$"npc's/hikari/espiritos".hide()
			$"npc's/hikari/AnimatedSprite2D".play("anim")
			await get_tree().create_timer(2).timeout
			$"npc's/hikari/AnimatedSprite2D".play("idle")
			$"npc's/hikari/CollisionShape2D".queue_free()
			$"npc's/yume/cisne".play()
		if yume_stage == true:
			get_node("/root/game/player").set_anim2()
			$"npc's/yume/yume_area/CollisionShape2D".queue_free()
			$player/luz.play()
			$player/sora_fx.play()
			$"npc's/yume/cisne".stop()
			await get_tree().create_timer(0.5).timeout
			$player/Light/PointLight2D_4.hide()
			$player/Light/PointLight2D_3.show()
			$"npc's/yume/light".show()
			$"npc's/yume/espiritos".hide()
			$"npc's/yume/AnimatedSprite2D".play("anim")
			await get_tree().create_timer(2).timeout
			$"npc's/yume/AnimatedSprite2D".play("idle")
			$"npc's/yume/CollisionShape2D".queue_free()
			$"npc's/haruka/falcao".play()
		if haruka_stage == true:
			get_node("/root/game/player").set_anim3()
			$"npc's/haruka/haruka_area/CollisionShape2D".queue_free()
			$player/luz.play()
			$player/sora_fx.play()
			$"npc's/haruka/falcao".stop()
			await get_tree().create_timer(0.5).timeout
			$player/Light/PointLight2D_3.hide()
			$player/Light/PointLight2D_2.show()
			$"npc's/haruka/light".show()
			$"npc's/haruka/espiritos".hide()
			##anim
			await get_tree().create_timer(2).timeout
			#$"npc's/haruka/AnimatedSprite2D".hide()
			$"npc's/haruka/CollisionShape2D".queue_free()
			$"npc's/nozomi/coruja".play()
		if nozomi_stage == true:
			get_node("/root/game/player").freeze()
			$"npc's/nozomi/nozomi_area/CollisionShape2D".queue_free()
			$player/luz.play()
			$player/sora_fx.play()
			$"npc's/nozomi/relogio".play()
			$player/forest_sound.stop()
			$player/vento_sound.stop()
			$player/music.stop()
			$"npc's/nozomi/coruja".stop()
			await get_tree().create_timer(2).timeout
			$player.hide()
			$cutscene/anim_death.show()
			$cutscene/anim_death.play()
			$"npc's/nozomi/light".show()
			$"npc's/nozomi/espiritos".hide()
			await get_tree().create_timer(8).timeout
			$"npc's/nozomi/relogio".stop()
			ui.credits()
			$player/Light/PointLight2D_2.hide()
			$cutscene/npc.show()
			await get_tree().create_timer(30).timeout
			$cutscene/anim_reborn.show()
			$cutscene/anim_reborn.play()
			await get_tree().create_timer(6).timeout
			ui.final_quote()
			await get_tree().create_timer(10).timeout
			ui.gameover()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_hikari_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_entered = true
		hikari_stage = true
		$"npc's/hikari/hikari_area/actionGUI".show()

func _on_hikari_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_entered = false
		hikari_stage = false
		$"npc's/hikari/hikari_area/actionGUI".hide()

func _on_yume_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_entered = true
		yume_stage = true
		$"npc's/yume/yume_area/actionGUI".show()

func _on_yume_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_entered = false
		yume_stage = false
		$"npc's/yume/yume_area/actionGUI".hide()

func _on_haruka_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_entered = true
		haruka_stage = true
		$"npc's/haruka/haruka_area/actionGUI".show()

func _on_haruka_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_entered = false
		haruka_stage = false
		$"npc's/haruka/haruka_area/actionGUI".hide()

func _on_nozomi_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_entered = true
		nozomi_stage = true
		$"npc's/nozomi/nozomi_area/actionGUI".show()

func _on_nozomi_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_entered = false
		nozomi_stage = false
		$"npc's/nozomi/nozomi_area/actionGUI".hide()
