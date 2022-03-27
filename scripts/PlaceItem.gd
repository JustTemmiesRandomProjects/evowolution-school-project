extends Node

func _on_PlaceItem_finished():
	queue_free()
