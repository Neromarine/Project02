extends KinematicBody2D

var velocity = Vector2.ZERO
var small_speed = 2.0
var initial_speed = 1.0
var health = 1
var Letter
var Label
var r
onready var Word_small = load("res://Word_Enemy/Word_Small.tscn")
var small_word = [Vector2(0,-30),Vector2(30,30),Vector2(-30,30)]

func _ready():
	velocity = Vector2(0,initial_speed*randf()).rotated(PI*2*randf())
	r = randi()%3
	if r == 1:
		Letter = Global.letter[randi()%26]
	else:
		Letter = Global.word[randi()%5]
		if Letter == "-":
			Letter = Global.letter[randi()%26]
	$Letter.text = Letter

func _physics_process(_delta):
	if Global.delete == 1:
		queue_free()
	position = position + velocity
	position.x = wrapf(position.x,0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)

func damage(_d):
	var Hit = 0
	for k in range(0,Global.word.size()):
		if Letter == Global.word[k]:
			Hit = 1
	health -= Hit
	if health <= 0:
		Global.letter_hit.append(Letter)
		Global.update_word()
		collision_layer = 0
		var Word_Enemy_Container = get_node_or_null("/root/Game/Word_Enemy_Container")
		if Word_Enemy_Container != null:
			for s in small_word:
				var word_small = Word_small.instance()
				var dir = randf()*2*PI
				var i = Vector2(0,randf()*small_speed).rotated(dir)
				Word_Enemy_Container.call_deferred("add_child", word_small)
				word_small.position = position + s.rotated(dir)
				word_small.velocity = i 
		queue_free()
	
func delete():
	queue_free()
	

