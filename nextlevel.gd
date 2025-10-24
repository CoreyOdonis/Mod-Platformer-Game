extends Area2D

const FILE_BEGIN = "res://levels/level_"

func _ready() -> void:
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	print("✅ NextLevel Area2D ready and waiting for player contact.")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("players"):
		print("🏁 Player reached level end flag!")

		var current_scene_path: String = get_tree().current_scene.scene_file_path
		var current_scene_name = current_scene_path.get_file().get_basename()  # e.g., "level_1"
		var current_level_number = int(current_scene_name.replace("level_", ""))

		var next_level_number = current_level_number + 1
		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"

		print("🌍 Attempting to load next level:", next_level_path)

		if ResourceLoader.exists(next_level_path):
			# ✅ Use call_deferred to avoid physics callback violation
			call_deferred("_load_next_level", next_level_path)
		else:
			push_warning("⚠️ Next level file not found: " + next_level_path)

func _load_next_level(next_level_path: String) -> void:
	Global.lives = 3
	Global.emit_signal("lives_changed")
	get_tree().change_scene_to_file(next_level_path)
	print("✅ Successfully loaded:", next_level_path)
