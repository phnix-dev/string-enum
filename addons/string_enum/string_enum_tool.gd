@tool
extends ConfirmationDialog


@export var folder_dialog: FileDialog
@export var suffix_name: LineEdit
@export var selected_folder: LineEdit
@export var button_folder: Button

var StringEnumPlugin := load("res://addons/string_enum/string_enum_plugin.gd")


func _on_confirmed() -> void:
	var suffix := suffix_name.text
	var folder := selected_folder.text
	
	if not suffix.is_empty() and not folder.is_empty():
		var path_suffixes: String = StringEnumPlugin.setting_string_suffix
		var suffixes: PackedStringArray = ProjectSettings.get_setting(path_suffixes).duplicate()
		
		if suffixes.find(suffix) == -1:
			suffixes.append(suffix)
						
			var scenes := get_all_scenes(folder)
			
			if not scenes.is_empty():
				var path_names: String = StringEnumPlugin.setting_string_names.path_join(suffix)
				var names := scenes.map(func(str: String): return str.get_file().get_slice(".", 0))
				var packed_names := PackedStringArray(names)
				
				ProjectSettings.set_setting(path_suffixes, suffixes)
				ProjectSettings.set_setting(path_names, packed_names)
				
				var names_formated = names.reduce(func(accum, str): return "%s, " % accum + str, "")
				names_formated = names_formated.right(-2)
				names_formated = "[%s]" % names_formated
				
				print("[String Enum] Enum values successfully created!")
				print("[String Enum] Suffix: %s" % suffix)
				print("[String Enum] Values: %s" % names_formated)
				print_rich("[String Enum] Due to a [url={https://github.com/godotengine/godot/issues/55145}]Godot bug[/url], the newly created enums may not be saved in the project.godot file, to fix this go to [code]Project Settings > Addons > String Enum > String Names > YourNewSuffix[/code], then add and remove an element from the array.")	
	
	queue_free()


func _on_line_edit_text_submitted(new_text: String) -> void:
	if not new_text.begins_with("_"):
		new_text = "_%s" % new_text
	
	suffix_name.text = new_text
	suffix_name.caret_column = new_text.length()


func _on_button_folder_button_down() -> void:
	folder_dialog.popup()
	

func _on_folder_dialog_dir_selected(dir: String) -> void:
	selected_folder.text = dir


func get_all_scenes(path: String) -> Array[String]:
	var array: Array[String] = []
	var current_path: String
	
	var dir = DirAccess.open(path)
		
	if dir:
		dir.list_dir_begin()
		
		var file_name = dir.get_next()
		
		while file_name != "":
			current_path = path.path_join(file_name)
			
			if dir.current_is_dir() and file_name != "addons":
				var subfolder_array = get_all_scenes(current_path)
				
				array.append_array(subfolder_array)
				
			elif file_name.get_extension() == "tscn":
				array.append(current_path)
				
			file_name = dir.get_next()
	else:
		printerr("An error occurred when trying to access the path.")
		
		return []
	
	return array
