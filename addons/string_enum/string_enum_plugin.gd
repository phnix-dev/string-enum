# ╔═════════════════════════════════════════════════════════════════════╗
# ║ This file is licensed under the Mozilla Public License Version 2.0. ║
# ╚═════════════════════════════════════════════════════════════════════╝

@tool
extends EditorPlugin


const TOOL_NAME := "Create Enum From Folder"
const TOOL_SCENE_PATH: PackedScene = preload("res://addons/string_enum/string_enum_tool.tscn")
const INSPECTOR_PATH: Script = preload("res://addons/string_enum/string_enum_inspector.gd")

var inspector: EditorInspectorPlugin


func _enter_tree() -> void:
	inspector = INSPECTOR_PATH.new()
	
	add_inspector_plugin(inspector)
	add_tool_menu_item(TOOL_NAME, _create_enums_from_folder)


func _exit_tree() -> void:
	remove_inspector_plugin(inspector)
	remove_tool_menu_item(TOOL_NAME)


func _create_enums_from_folder() -> void:
	var scene = TOOL_SCENE_PATH.instantiate()
	
	add_child(scene)
