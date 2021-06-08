extends Position2D


# Declare member variables here. Examples:
# var a = 2
var selected = false
var nome #Nome da peca atual selecionada


# Called when the node enters the scene tree for the first time.
func _ready():
	nome = ""

func select(nomeSel):
	selected = true
	nome = nomeSel

func deselect():
	selected = false
	nome = ""
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
