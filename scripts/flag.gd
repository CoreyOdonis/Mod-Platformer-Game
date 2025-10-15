@tool
class_name Flag
extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var ui = get_node("/root/Main/UI")

var player_reached_flag := false

enum FlagPosition {
	DOWN,
	UP,
}

## Use this to change the sprite frames of the flag.
@export var sprite_frames: SpriteFrames = _initial_sprite_frames:
	set = _set_sprite_frames

@export var flag_position: FlagPosition = FlagPosition.DOWN:
	set = _set_flag_position

@onready var _sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var _initial_sprite_frames: SpriteFrames = %AnimatedSprite2D.sprite_frames


func _set_sprite_frames(new_sprite_frames):
	sprite_frames = new_sprite_frames
	if sprite_frames and is_node_ready():
		_sprite.sprite_frames = sprite_frames


func _set_flag_position(new_flag_position):
	flag_position = new_flag_position
	if not is_node_ready():
		pass
	elif flag_position == FlagPosition.DOWN:
		_sprite.play("down")
	else:
		_sprite.play("up")


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_sprite_frames(sprite_frames)
	_set_flag_position(flag_position)


func _on_body_entered(body):
	if body.is_in_group("players") and not player_reached_flag:
		player_reached_flag = true
		if animated_sprite:
			animated_sprite.play("up")
		if ui:
			ui.show_win_message()
		if body.has_method("stop_movement"):
			body.stop_movement()
