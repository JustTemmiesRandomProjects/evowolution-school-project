extends Sprite

var R = 0.0
var G = 0.0
var B = 0.0

var R_up_or_down = 1
var G_up_or_down = 1
var B_up_or_down = 1

var Mat

func _ready():
	Mat = self.get_material()
	Mat.set_shader_param("R",R)
	Mat.set_shader_param("G",G)
	Mat.set_shader_param("B",B)


#func _process(delta: float) -> void:
#
##   PRESS CTRL K TO COMMENT / UNCOMMENT MULTIPLE LINES
#
#	Mat = self.get_material()
#	Mat.set_shader_param("R",R)
#	Mat.set_shader_param("G",G)
#	Mat.set_shader_param("B",B)
#
#	if R_up_or_down == 1:
#		if R <= 1:
#			R += 0.01
#		else:
#			R_up_or_down = 0
#	else:
#		if R >= -0.6:
#			R -= 0.01
#		else:
#			R_up_or_down = 1
#
#	if G_up_or_down == 1:
#		if G <= 1:
#			G += 0.01
#		else:
#			G_up_or_down = 0
#	else:
#		if G >= -0.8:
#			G -= 0.01
#		else:
#			G_up_or_down = 1
#
#	if B_up_or_down == 1:
#		if B <= 0.6:
#			B += 0.01
#		else:
#			B_up_or_down = 0
#	else:
#		if B >= -1:
#			B -= 0.01
#		else:
#			B_up_or_down = 1
