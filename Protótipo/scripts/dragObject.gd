extends Node2D

var selected = false
var restPoint
var restNodes = []
var restID

func _ready():
	restNodes = get_tree().get_nodes_in_group("zone")
	restPoint = restNodes[0].global_position
	restNodes[0].select(self.name)
	restID = 0
	

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(),25*delta)
	else:
		global_position = lerp(global_position, restPoint, 10*delta)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			var menorDistancia = global_position.distance_to(restNodes[restID].global_position)
			var ID = restID
			for k in range(len(restNodes)):
				var child = restNodes[k]
				var distance = global_position.distance_to(child.global_position)
				if distance < menorDistancia:
					menorDistancia = distance
					ID = k
			
			if (not restNodes[ID].selected):
				restNodes[restID].deselect()
				restID = ID
				restPoint = restNodes[restID].global_position
				restNodes[restID].select(self.name)
				
