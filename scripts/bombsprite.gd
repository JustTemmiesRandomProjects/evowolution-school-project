extends "res://Animals/Sprite.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


var R_up_or_down = 1
var timer = 1

signal boom

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:

#   PRESS CTRL K TO COMMENT / UNCOMMENT MULTIPLE LINES

	Mat = self.get_material()
	Mat.set_shader_param("R",R)
	Mat.set_shader_param("G",G)
	Mat.set_shader_param("B",B)

	if R_up_or_down == 1:
		if R <= 1:
			R += timer*0.01
		else:
			R_up_or_down = 0
	else:
		if R >= 0:
			R -= timer*0.01
		else:
			R_up_or_down = 1
	
	timer += timer*delta*0.3
	
	if timer >= 50:
		emit_signal("boom")
