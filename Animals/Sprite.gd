extends Sprite

var R = 0.0
var G = 0.0
var B = 0.0

var Mat

func _ready():
	Mat = self.get_material()
	Mat.set_shader_param("R",R)
	Mat.set_shader_param("G",G)
	Mat.set_shader_param("B",B)
