extends Area2D

@export var value: int = 5  # number of coins or points

func _ready() -> void:
	# connect the signal to detect player contact
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Only react if the object is the player
	if not body.is_in_group("players"):
		return

	# Optional: Play sound if you have AudioStreamPlayer2D
	if has_node("AudioStreamPlayer2D"):
		$AudioStreamPlayer2D.play()

	# Disable collision so it can't trigger again
	set_deferred("monitoring", false)

	# Optional: Update global coin count if you have a Global script
	if Engine.has_singleton("Global"):
		var global = Engine.get_singleton("Global")
		if global.has_method("add_coin"):
			global.add_coin(value)

	# Wait a moment for sound to play, then remove the coin
	if has_node("AudioStreamPlayer2D"):
		await get_tree().create_timer(0.2).timeout

	queue_free()
