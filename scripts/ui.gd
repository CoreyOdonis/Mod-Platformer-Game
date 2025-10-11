extends CanvasLayer

@export var restart_scene_path: String = ""     # Optional: path to the level to restart
@export var main_menu_scene_path: String = ""   # Optional: path to main menu scene

@onready var win_label: Label = $WinLabel
@onready var win_menu: Control = $WinMenu
@onready var restart_button: Button = $WinMenu/RestartButton
@onready var main_menu_button: Button = $WinMenu/MainMenuButton

func _ready() -> void:
	# Hide UI elements at start
	win_label.visible = false
	win_menu.visible = false

	# Connect button signals
	restart_button.pressed.connect(_on_restart_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

func show_message(text: String) -> void:
	win_label.text = text
	win_label.visible = true

func hide_message() -> void:
	win_label.visible = false

func show_win_menu(visible_state: bool = true) -> void:
	win_menu.visible = visible_state

# --- Button Callbacks ---
func _on_restart_pressed() -> void:
	get_tree().paused = false
	if restart_scene_path != "":
		get_tree().change_scene_to_file(restart_scene_path)
	else:
		get_tree().reload_current_scene()  # fallback: reload the current level

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	if main_menu_scene_path != "":
		get_tree().change_scene_to_file(main_menu_scene_path)
	else:
		push_warning("Main menu scene path not set in inspector!")
