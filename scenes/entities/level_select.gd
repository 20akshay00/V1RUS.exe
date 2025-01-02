extends Area2D
class_name LevelSelect

var _key_tween: Tween = null
var _rect: Rect2 

@export var level_idx: int

func _ready() -> void:
	_rect = $Overlay.region_rect

func _on_body_entered(body: Node2D) -> void:
		await get_tree().create_timer(0.25).timeout

		$Overlay.region_rect = Rect2(_rect.position - Vector2(0, _rect.size.y), _rect.size)
		if _key_tween: _key_tween.kill()
		_key_tween = get_tree().create_tween()
		_key_tween.tween_property($Overlay, "modulate:a", 1.0, 0.3)
		AudioManager.play_effect(AudioManager.hash_press_sfx)

func _on_body_exited(body: Node2D) -> void:
	if _key_tween: _key_tween.kill()
	_key_tween = get_tree().create_tween()
	_key_tween.tween_property($Overlay, "modulate:a", 0., 0.3)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("infect") and get_overlapping_bodies():
		LevelManager.load_level(level_idx)
