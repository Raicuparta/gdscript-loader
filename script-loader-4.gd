extends Node

func _ready() -> void:
	var base_dir = get_script().resource_path.get_base_dir()
	var mods_path = base_dir.path_join("mods")

	var gd_files = _get_mod_scripts(mods_path)
	var mod_counter = 1

	for file_path in gd_files:
		var script_res = load(file_path)
		if script_res:
			var instance = script_res.new()
			if instance is Node:
				# Name them sequentially: RaiPalMod_1, RaiPalMod_2, etc.
				instance.name = "RaiPalMod_" + str(mod_counter)
				mod_counter += 1

				get_tree().root.call_deferred("add_child", instance)
				print("Loaded Mod: ", instance.name, " from ", file_path)

func _get_mod_scripts(mods_path: String) -> Array[String]:
	var result: Array[String] = []

	if not DirAccess.dir_exists_absolute(mods_path):
		print("No 'mods' directory found at: ", mods_path)
		return result

	var mod_folders = DirAccess.get_directories_at(mods_path)

	for mod_name in mod_folders:
		var mod_path = mods_path.path_join(mod_name)
		var files = DirAccess.get_files_at(mod_path)

		for file_name in files:
			if file_name.ends_with(".gd"):
				result.append(mod_path.path_join(file_name))

	return result