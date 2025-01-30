extends Node3D


# dlg is short for dialogue

@export var character_name : String
@export_multiline var text : String
var char_dialogue : Dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	char_dialogue = Dialogue.new("Jeff", "Bungler the bungle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_talk_box_body_entered(body: Node3D) -> void:
	
	pass


func _on_talk_box_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
