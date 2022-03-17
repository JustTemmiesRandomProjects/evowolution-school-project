extends Node2D

var fromorg = Vector2(50,0)
var toorg = Vector2(0,0)

func draw(from, to):
	fromorg = from
	toorg = to
	update()

func _draw() -> void:
	draw_line(fromorg, toorg, Color(1,1,1), 10)
	
