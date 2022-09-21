extends Node2D

onready var Word_Enemy = load("res://Word_Enemy/Word_Enemy.tscn")

func _on_Timer_timeout():
	var word_enemy = Word_Enemy.instance()
	self.call_deferred("add_child", word_enemy)
