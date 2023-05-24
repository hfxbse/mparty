class_name JSONLoader extends Resource

func load_json_file(file_path: String):
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path, FileAccess.READ)
		assert(data_file != null, "Couldn't read file.")
		var parsed_data = JSON.parse_string(data_file.get_as_text())
		
		if parsed_data is Dictionary:
			return parsed_data
		else:
			print("Couldn't read file.")
			return null
	else:
		print("File doesn't exists.")
		return null
