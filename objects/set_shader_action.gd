class_name SetShaderAction
extends ActionLeaf

@export var canvas_item : CanvasItem
@export var material : Material

func before_run(actor: Node, blackboard: Blackboard) -> void:
	canvas_item.material = material
	 
