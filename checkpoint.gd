extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var spawn_point: Marker2D = $SpawnPoint
var activated: bool = false

func _ready() -> void:
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	if animated_sprite and animated_sprite.sprite_frames.has_animation("down"):
		animated_sprite.play("down")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players") and not activated:
		activated = true
		if animated_sprite and animated_sprite.sprite_frames.has_animation("up"):
			animated_sprite.play("up")

		GameManager.set_respawn_point(spawn_point.global_position)
		print("✅ Checkpoint activated at:", spawn_point.global_position)
