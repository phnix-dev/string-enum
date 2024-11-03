# ╔═════════════════════════════════════════════════════════════════════╗
# ║ This file is licensed under the Mozilla Public License Version 2.0. ║
# ╚═════════════════════════════════════════════════════════════════════╝

@tool
extends ConfirmationDialog


const ENUM_TEXT := """enum %s {
%s
}
"""
const ENUM_VALUE := """	"%s",\n"""





@export var folder_dialog: FileDialog
@export var enum_name: LineEdit
@export var selected_folder: LineEdit
@export var button_folder: Button

var StringEnumPlugin := load("res://addons/string_enum/string_enum_plugin.gd")
var generate_button: Button


func _ready() -> void:
	generate_button = get_ok_button()
	generate_button.disabled = true
	generate_button.release_focus()

func _on_confirmed() -> void:
	var name := enum_name.text
	var folder := selected_folder.text
	
	if not name.is_empty() and not folder.is_empty():
		var scenes := get_all_scenes(folder)
			
		if not scenes.is_empty():
			var names_formated: String = scenes.reduce(
				func(accum: String, path: String):
					var file_name := path.get_file().get_slice(".", 0).to_upper()
					
					return accum + ENUM_VALUE % file_name \
				, ""
			)
			names_formated = names_formated.trim_suffix("\n")
			names_formated = ENUM_TEXT % [name, names_formated]
			
			DisplayServer.clipboard_set(names_formated)
						
			print("[String Enum] It is copied to your clipboard.")
		else:
			print("[String Enum] Could not create the enum from the folder!")
			print("[String Enum] The folder contains no scenes!")
	
	queue_free()


func _on_line_edit_name_text_submitted(new_text: String) -> void:
	new_text = new_text.left(1).to_upper() + new_text.right(-1)
	
	enum_name.text = new_text
	enum_name.caret_column = new_text.length()
	
	_enable_generate_button()


func _on_button_folder_button_down() -> void:
	folder_dialog.popup()
	

func _on_folder_dialog_dir_selected(dir: String) -> void:
	selected_folder.text = dir
	
	_enable_generate_button()


func _enable_generate_button() -> void:
	generate_button.disabled = selected_folder.text.is_empty() or enum_name.text.is_empty()


func get_all_scenes(path: String) -> Array[String]:
	var array: Array[String] = []
	var current_path: String
	
	var dir = DirAccess.open(path)
		
	if dir:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		
		while file_name != "":
			current_path = path.path_join(file_name)
			
			if dir.current_is_dir() and file_name != "addons" and file_name != ".godot":
				var subfolder_array = get_all_scenes(current_path)
				
				array.append_array(subfolder_array)
			else:
				array.append(current_path)
				
			file_name = dir.get_next()
	else:
		printerr("An error occurred when trying to access the path.")
		
		return []
	
	return array
