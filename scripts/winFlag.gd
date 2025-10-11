extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ui: CanvasLayer = get_node("/root/Main/UI")  # Adjust path if needed
@onready var ui_label: Label = get_node("../UI/WinLabel") # Adjust if needed

var player_reached_flag = false

func _ready():
	if animated_sprite:
		animated_sprite.stop()
	if ui_label:
		ui_label.visible = false

func _on_body_entered(body):
	if body.is_in_group("players"):
		player_reached_flag = true
		if animated_sprite:
			animated_sprite.play("up")  # Make sure you have an animation named "wave"
		if ui_label:
			ui_label.text = "🎉 YOU WIN! Press [E] to continue"
			ui_label.visible = true
		# Stop player movement if possible
		if body.has_method("stop_movement"):
			body.stop_movement()
		elif "velocity" in body:
			body.velocity = Vector2.ZERO

func _process(_delta):
	if player_reached_flag and Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://NextLevel.tscn")
