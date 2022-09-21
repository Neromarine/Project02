extends Control

onready var indicator = load("res://UI/Indicator.tscn")

var lives_pos = Vector2.ZERO
var lives_index = 30
var Word
var Current_Word


func _ready():
	update_score()
	update_time()
	update_lives()
	update_word()
	pass

func update_score():
	$Score.text = "Score: " + str(Global.score)
func update_time():
	$Time.text = "Time Remaining: " + str(Global.time)
func update_word():
	Word = Global.word
	if Global.letter_hit.size() != 0:
		for i in range(0,Word.size()):
			for k in range(0 ,Global.letter_hit.size()):
				if Word[i] == Global.letter_hit[k]:
					Word[i] = "-"
	Current_Word = Word[0] +Word[1]+Word[2]+Word[3]+Word[4]
	print(Current_Word)
	check_word()
	$Word.text = "Current Word: " + Current_Word
	
func check_word():
	if Current_Word == "-----":
		Global.update_score(100)
		Global.rand_word()
		Current_Word = Global.word[0] + Global.word[1] + Global.word[2] + Global.word[3] +Global. word[4]
	
	
func update_lives():
	lives_pos = Vector2(20,Global.VP.y - 20)
	for child in $indicator_container.get_children():
		child.queue_free()
	for i in range(Global.lives):
		var Indicator = indicator.instance()
		Indicator.position = Vector2(lives_pos.x + i*lives_index, lives_pos.y)
		$indicator_container.add_child(Indicator)




func _on_Timer_timeout():
	Global.time -= 1
	if Global.time < 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		update_time()


