extends Sprite

var mouseIn = false
var dragging = false
var previousMousePosition = Vector2()
func _ready():
	pass


func _on_Area2D_mouse_entered():
	mouseIn = true


func _on_Area2D_mouse_exited():
	mouseIn = false

func _process(delta):
#	if (mouseIn and Input.is_action_pressed("click")):
#		set_position(get_viewport().get_mouse_position())
	pass


func _on_Area2D_drag_event(viewport, event, shape_idx):
	#Permite arrastar se o mouse estiver sobre a area
	if event.is_action_pressed("click"):
		print(event.position)
		get_tree().set_input_as_handled()
		previousMousePosition = event.position
		dragging = true

func _input(event):
	
	if not dragging:
		return
	
	if event.is_action_released("click"):
		previousMousePosition = Vector2()
		dragging = false
	
	if dragging and event is InputEventMouseMotion:
		position += event.position - previousMousePosition
		previousMousePosition =  event.global_position
		
	
