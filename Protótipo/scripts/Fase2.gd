extends Node2D


func _ready():
	pass


func _on_Vermelho_pressed():
	$Resultado.text = "Você Acertou"


func _on_Erro_pressed():
	$Resultado.text = "Você Errou"
