extends Node2D

var edit
var console

var helptext = "COMMANDS: \nattack [target]\ndefend [target]\nhelp"

# Called when the node enters the scene tree for the first time.
func _ready():
	edit = get_node("LineEdit")
	console = get_node("Console")
	console.text = helptext
	if (edit == null):
		print("lineedit is null")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_submitted(new_text):
	print(new_text)
	console.text += ">" + new_text + "\n"
	console.text += parsetext(new_text) + "\n"
	console.scroll_to_line(console.get_line_count()-1) 
	edit.clear()
func parsetext(text) -> String:
	var tokens = text.rsplit(" ", true, 1)
	var str = ""
	if (text == ""):
		return "ERROR: BLANK SPACE"
	var cmd = tokens[0].to_lower()
	
	if (cmd == "attack"):
		if (tokens.size() > 1):
			var ent = get_node("../../BUILDINGS/"+tokens[1].to_lower())
			if (ent != null):
				for N in get_node("../../NPCs").get_children():
					if (N.allegence == "player"):
						N.maintarget = ent
				return "target found"
			else:
				return "target not found: " + tokens[1]
			pass
		return "move to?"
	elif (cmd == "help"):
		return helptext
	return str
