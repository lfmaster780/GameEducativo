extends Node2D

var exit = false
var selected = false
var restPoint
var restID = 0
var restNodes = []
var initPoint

var pointsID = []

func _ready():
	restNodes = get_tree().get_nodes_in_group("initZone")
	restPoint = restNodes[0].global_position
	
	initPoint = restPoint
	
	restID = -1
	restNodes = get_tree().get_nodes_in_group("zone")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(),25*delta)
	else:
		global_position = lerp(global_position, restPoint, 10*delta)

func areaClick(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _on_Area2D_input_event(viewport, event, shape_idx):
	areaClick(viewport, event, shape_idx)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			if exit:
				restID = -1
				restPoint = initPoint
				for i in pointsID:
					restNodes[i].deselect()
				pointsID = []
				return
				
			var menorDistancia
			if restID == -1:
				menorDistancia = global_position.distance_to(initPoint)
			else:
				menorDistancia = global_position.distance_to(restNodes[restID].global_position)
			var ID = restID
			
			for k in range(len(restNodes)):
				var child = restNodes[k]
				var distance = global_position.distance_to(child.global_position)
				if distance < menorDistancia:
					menorDistancia = distance
					ID = k
			
			var valid = false
			if (ID+6 < len(restNodes)) and (restNodes[ID+6].selected == false):
				if restNodes[ID+3].selected == false:
					valid = true
			
			if ID == -1:
				valid = false
				return
				
			
			if (restNodes[ID].selected == false) and valid:
				for i in self.pointsID:
					restNodes[i].deselect()
				
				self.pointsID = []
				self.pointsID.append(ID)
				self.pointsID.append(ID+3)
				self.pointsID.append(ID+6)
				restID = ID
				
				for j in self.pointsID:
					restNodes[j].select()
				
				restPoint = restNodes[restID].global_position
				
			


func _on_Area2D_area_entered(area):
	if area.is_in_group("exit"):
		exit = true


func _on_Area2D_area_exited(area):
	if area.is_in_group("exit"):
		exit = false
