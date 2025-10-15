extends StaticBody2D

@export var coin_scene: PackedScene
var activated := false

@onready var detection: Area2D = $Detection

func _ready() -> void:
	if detection:
		detection.body_entered.connect(_on_body_entered)
	else:
		push_error("No 'Detection' node found in SecretBlock scene!")

func _on_body_entered(body: Node) -> void:
	if activated:
		return

	if body.is_in_group("players"):
		activated = true
		call_deferred("_spawn_coin")
		# _play_animation()  # disable until you add AnimationPlayer

func _spawn_coin() -> void:
	if coin_scene:
		var coin = coin_scene.instantiate()
		get_parent().add_child(coin)
		coin.global_position = global_position + Vector2(0, -32)
	else:
		push_warning("coin_scene not set in the Inspector!")
