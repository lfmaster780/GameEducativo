extends Node2D


func _ready():
	pass


func _on_BotaoCerto_pressed():
	print("Certo")
	$Label2.text = "CORRETO"
	$Continuar.visible = true


func _on_BotaoErrado_pressed():
	print("Errado")
	$Label2.text = "ERRADO"
	$Continuar.visible = false


func _on_Continuar_pressed():
	get_tree().change_scene("res://scenes/Fase2.tscn")
