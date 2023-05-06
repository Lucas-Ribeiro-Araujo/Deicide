extends Control

const FADE_TIME:float = 4

@export var scenes:Array[CutsceneSceneInfo]

@onready var audio_player:AudioStreamPlayer = $AudioPlayer
@onready var text:Label = $Visual/Text
@onready var background:ColorRect = $Visual/Background
@onready var panel:Panel = $Visual

var current_scene:CutsceneSceneInfo
var current_scene_index:int = 0

func _ready():
	init_scene(scenes[current_scene_index])

func _process(delta):
	if current_scene:
		update_scene(current_scene, delta)
	else:
		panel.modulate = panel.modulate.lerp(Color.TRANSPARENT, FADE_TIME * delta)

func update_scene(new_scene_inf:CutsceneSceneInfo, delta:float) -> void:
	panel.modulate = panel.modulate.lerp(Color.WHITE, FADE_TIME * delta)


func init_scene(new_scene_inf:CutsceneSceneInfo) -> void:
	background.color = new_scene_inf.background_color
	text.add_theme_color_override("font_color", new_scene_inf.text_color)
	text.text = new_scene_inf.text
	audio_player.stream = new_scene_inf.audio
	audio_player.play()
	panel.modulate = Color.TRANSPARENT
	
	current_scene = new_scene_inf


func _on_audio_player_finished():
	current_scene_index += 1
	if current_scene_index >= scenes.size():
		current_scene = null
		current_scene_index = 0
	else:
		init_scene(scenes[current_scene_index])
