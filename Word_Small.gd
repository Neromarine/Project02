extends KinematicBody2D

var health = 1
var velocity = Vector2.ZERO
var Letter
var Effects
onready var Explosion = load("res://Effects/Explosion.tscn")

func _ready():
	Letter = Global.letter[randi()%26]
	$Letter.text = Letter

func _physics_process(_delta):
	if Global.delete == 1:
		queue_free()
	position += velocity
	position.x = wrapf(position.x,0,Global.VP.x)
	position.y = wrapf(position.y,0,Global.VP.y)

func damage(_d):
	var Hit = 0
	for k in range(0,Global.word.size()):
		if Letter == Global.word[k]:
			Hit = 1
	health -= Hit
	if health <= 0:
		Global.letter_hit.append(Letter)
		Global.update_word()
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
		queue_free()
func delete():
	queue_free()
