extends Node

var score
var time
var lives
var delete

var VP = null

var letter = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
var letter_hit=[]
var word


onready var Word_Enemy_Container = get_node_or_null("/root/Game/Word_Enemy_Container")

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	rand_word()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed",self,"_resize")
	reset()

func _resize():
	VP = get_viewport().size
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_lives()

func rand_word():
	letter_hit=[]
	word = [letter[randi()%26],letter[randi()%26],letter[randi()%26],letter[randi()%26],letter[randi()%26] ]


func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var Pause_Menus = get_node_or_null("/root/Game/UI/Pause_Menus")
		if Pause_Menus == null:
			get_tree().quit()
		else:
			if Pause_Menus.visible:
				Pause_Menus.hide()
				get_tree().paused = false
			else:
				Pause_Menus.show()
				get_tree().paused = true

func reset():
	score = 0
	time = 100
	lives = 5
	rand_word()
	update_word()
	
func update_score(s):
	score = score + s
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_score()

func update_lives(l):
	delete = 1
	lives += l
	if lives < 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_lives()	
		
func update_word():
	var HUD = get_node_or_null("/root/Game/UI/HUD")
	if HUD != null:
		HUD.update_word()
