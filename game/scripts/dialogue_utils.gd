extends Node

func load_file_as_JSON(path):
	var file = File.new()
	file.open(path, file.READ)
	var content = (file.get_as_text())
	var parsedContent = parse_json(content)
	file.close()
	return parsedContent