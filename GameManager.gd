extends Node

var respawn_point: Vector2 = Vector2.ZERO

func set_respawn_point(pos: Vector2) -> void:
	respawn_point = pos
	print("💾 Respawn point saved:", respawn_point)

func get_respawn_point() -> Vector2:
	return respawn_point

func clear_respawn_point() -> void:
	respawn_point = Vector2.ZERO
	print("🧹 Respawn point cleared")
