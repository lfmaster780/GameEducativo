extends Node2D

var exit = false
var selected = false
var restPoint
var restID = 0
var restNodes = []
var initPoint

var pointsID = []
var tamanho
var ultimaRot = self.rotation_degrees
# Called when the node enters the scene tree for the first time.
func _ready():
	tamanho = get_parent().tamanho
	restPoint = self.global_position
	
	
	initPoint = restPoint
	
	restID = -1
	restNodes = get_tree().get_nodes_in_group("zone")
	
func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(),25*delta)
	else:
		global_position = lerp(global_position, restPoint, 10*delta)


func areaClick(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _on_Area_input_event(viewport, event, shape_idx):
	areaClick(viewport, event, shape_idx)


func _on_Area_area_entered(area):
	if area.is_in_group("exit"):
		exit = true


func _on_Area_area_exited(area):
	if area.is_in_group("exit"):
		exit = false

func _input(event):
	if Input.is_action_just_pressed("rotate") and selected:
		if self.rotation_degrees == 0:
			self.rotation_degrees = 180
		else:
			self.rotation_degrees = 0
		
	if event is InputEventMouseButton:
		
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			if exit:
				restID = -1
				restPoint = initPoint
				for i in pointsID:
					restNodes[i].deselect()
				pointsID = []
				self.rotation_degrees = 0
				return
			print("Nome: ",self.name)
			
			if self.rotation_degrees == 0:
				validarPosicao()
			else:
				validarPosicao180()

func validarPosicao():
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
	if ID+(tamanho*2)+1 >= len(restNodes) or (ID % tamanho == tamanho - 1):
		self.rotation_degrees = ultimaRot
		return
	var flag = (restNodes[ID+(tamanho*2)+1].nome == self.name) or (restNodes[ID+(tamanho*2)+1].selected == false)
	var flag2 = (restNodes[ID+(tamanho*2)].nome == self.name) or (restNodes[ID+(tamanho*2)].selected == false)

	if flag and flag2:
		if restNodes[ID+tamanho].selected == false or restNodes[ID+tamanho].nome == self.name:
			valid = true
		
	if ID == -1:
		valid = false
		self.rotation_degrees = ultimaRot
		return
	
		
	if (restNodes[ID].selected == false or (restNodes[ID].nome == self.name)) and valid:
		for i in self.pointsID:
			restNodes[i].deselect()
		
		self.pointsID = []
		self.pointsID.append(ID)
		self.pointsID.append(ID+tamanho)
		self.pointsID.append(ID+(tamanho*2))
		self.pointsID.append(ID+(tamanho*2)+1)
		restID = ID
		
		for j in self.pointsID:
			restNodes[j].select(self.name)
		
		restPoint = restNodes[restID].global_position
		ultimaRot = self.rotation_degrees
		
	else:
		self.rotation_degrees = ultimaRot

func validarPosicao180():
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
	if ID-(tamanho*2)-1 < 0 or (ID % tamanho == 0):
		self.rotation_degrees = ultimaRot
		return
	var flag = (restNodes[ID-(tamanho*2)-1].nome == self.name) or (restNodes[ID-(tamanho*2)-1].selected == false)
	var flag2 = (restNodes[ID-(tamanho*2)].nome == self.name) or (restNodes[ID-(tamanho*2)].selected == false)

	if flag and flag2:
		if restNodes[ID-tamanho].selected == false or restNodes[ID-tamanho].nome == self.name:
			valid = true
		
	if ID == -1:
		valid = false
		self.rotation_degrees = ultimaRot
		return
	
		
	if (restNodes[ID].selected == false or (restNodes[ID].nome == self.name)) and valid:
		for i in self.pointsID:
			restNodes[i].deselect()
		
		self.pointsID = []
		self.pointsID.append(ID)
		self.pointsID.append(ID-tamanho)
		self.pointsID.append(ID-(tamanho*2))
		self.pointsID.append(ID-(tamanho*2)-1)
		restID = ID
		
		for j in self.pointsID:
			restNodes[j].select(self.name)
		
		restPoint = restNodes[restID].global_position
		ultimaRot = self.rotation_degrees
		
	else:
		self.rotation_degrees = ultimaRot
	
