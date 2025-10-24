extends CanvasLayer

@export var restart_scene_path: String = ""     # path to your level scene (optional)
@export var main_menu_scene_path: String = ""   # path to main menu scene (optional)

@onready var win_label: Label = $WinLabel
@onready var win_menu: Control = $WinMenu
@onready var restart_btn: Button = $WinMenu/RestartButton
@onready var menu_btn: Button = $WinMenu/MainMenuButton
@onready var pause_label: Label = $PauseLabel  # Add a Label node to show "GAME PAUSED"


func _ready() -> void:
	
	win_label.visible = false
	win_menu.visible = false
	pause_label.visible = false


	# ✅ Automatically assign current scene as restart path if not set in Inspector
	if restart_scene_path == "":
		var current_scene := get_tree().current_scene
		if current_scene:
			restart_scene_path = current_scene.scene_file_path
			print("✅ Auto-assigned restart_scene_path to: ", restart_scene_path)

	if restart_btn and not restart_btn.pressed.is_connected(_on_restart_pressed):
		restart_btn.pressed.connect(_on_restart_pressed)
	if menu_btn and not menu_btn.pressed.is_connected(_on_main_menu_pressed):
		menu_btn.pressed.connect(_on_main_menu_pressed)


func show_win_message() -> void:
	get_tree().paused = true
	win_label.text = "🎉 YOU WIN! 🎉"
	win_label.visible = true

	var tween := create_tween()
	win_label.modulate.a = 0.0
	tween.tween_property(win_label, "modulate:a", 1.0, 0.8)

	await get_tree().create_timer(1.5).timeout
	show_win_menu(true)


func show_win_menu(visible_state: bool = true) -> void:
	if win_menu:
		win_menu.visible = visible_state
		win_menu.modulate.a = 1.0
	else:
		push_warning("WinMenu node not found in UI.gd")
		
func show_game_over() -> void:
	get_tree().paused = true
	win_label.text = "💀 GAME OVER 💀"
	win_label.visible = true

	var tween := create_tween()
	win_label.modulate.a = 0.0
	tween.tween_property(win_label, "modulate:a", 1.0, 0.8)

	await get_tree().create_timer(1.0).timeout
	show_win_menu(true)



func _on_restart_pressed() -> void:
	get_tree().paused = false

	# 🧹 Clear checkpoint before restarting
	if Engine.has_singleton("GameManager"):
		var gm = Engine.get_singleton("GameManager")
		gm.clear_respawn_point()
	elif typeof(GameManager) == TYPE_OBJECT:
		GameManager.clear_respawn_point()

	# ✅ Restart from restart_scene_path (auto-assigned or manually set)
	if restart_scene_path != "":
		get_tree().change_scene_to_file("res://levels/level_1.tscn")
	else:
		push_warning("UI: restart_scene_path not set or could not be auto-assigned.")


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	if main_menu_scene_path != "":
		get_tree().change_scene_to_file(main_menu_scene_path)
	else:
		push_warning("UI: main_menu_scene_path not set in the Inspector.")
