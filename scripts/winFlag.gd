extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ui = get_node("/root/Main/UI")

var player_reached_flag := false

func _on_body_entered(body):
	if body.is_in_group("players") and not player_reached_flag:
		player_reached_flag = true
		
		# ✅ Fixed: Check for animation properly
		if animated_sprite and animated_sprite.sprite_frames.has_animation("up"):
			animated_sprite.play("up")

		# Show win menu via UI script
		if ui:
			ui.show_win_message()
		else:
			push_error("UI node not found. Check the path '/root/Main/UI'")

		# Optional: stop player movement
		if body.has_method("stop_movement"):
			body.stop_movement()
