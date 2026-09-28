extends Node

func _ready() -> void:
	var base_dir = get_script().resource_path.get_base_dir()
	var mods_path = base_dir.plus_file("mods")

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

func _get_mod_scripts(mods_path: String) -> Array:
	var result = []
	var mods_dir = Directory.new()

	if mods_dir.open(mods_path) == OK:
		mods_dir.list_dir_begin(true, true)
		var mod_folder_name = mods_dir.get_next()

		while mod_folder_name != "":
			if mods_dir.current_is_dir():
				var mod_path = mods_path.plus_file(mod_folder_name)
				var inner_dir = Directory.new()

				if inner_dir.open(mod_path) == OK:
					inner_dir.list_dir_begin(true, true)
					var file_name = inner_dir.get_next()

					while file_name != "":
						if not inner_dir.current_is_dir() and file_name.ends_with(".gd"):
							result.append(mod_path.plus_file(file_name))
						file_name = inner_dir.get_next()

					inner_dir.list_dir_end()

			mod_folder_name = mods_dir.get_next()

		mods_dir.list_dir_end()
	else:
		print("No 'mods' directory found at: ", mods_path)

	return result