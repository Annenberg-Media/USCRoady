class_name Data extends Resource

@export var high_score:int = 0;

const SAVE_PATH:String = "user://high_score.tres"

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH);
	
static func load_create() -> Data:
	var res:Data;
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as Data;
	else:
		res = Data.new();
	return res;
