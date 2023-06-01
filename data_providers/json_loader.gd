class_name JSONLoader extends Resource

func load_json_file(file_path: String):
	var data_file = FileAccess.open(file_path, FileAccess.READ)
	assert(data_file != null, "Couldn't read file at \"%s\"." % file_path)
	var parsed_data = JSON.parse_string(data_file.get_as_text())
	assert(parsed_data is Dictionary, "Coudln't parse file at \"%s\"." % file_path)
	return parsed_data
