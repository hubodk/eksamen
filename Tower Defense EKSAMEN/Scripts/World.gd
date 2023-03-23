extends Node2D

var tower = preload("res://Scenes/Tower.tscn")
var tower1 = preload("res://Scenes/Tower1.tscn")
var mob = preload("res://Scenes/Enemy.tscn")
var instance

var building = false

var money = 25
var wave = 0
var mobs_left = 0
var wave_mobs = [1,1,5,10,100,0]
var wave_speed = [1.2,1,1,1,0.1,100]

func _ready():
	$WaveTimer.start()

func _process(delta):
	$GUI/CashLabel.text = "Cash: " + str(money)
	
func add_money(amount):
	money += amount
	
func tower_built():
	building = false
	money -= 25



func _on_WaveTimer_timeout():
	mobs_left = wave_mobs[wave]
	$MobTimer.wait_time = wave_speed[wave]
	$MobTimer.start()
	



func _on_MobTimer_timeout():
	instance = mob.instance()
	$Path2D.add_child(instance)
	mobs_left -= 1
	if mobs_left <= 0:
		$MobTimer.stop()
		wave +=1
		if wave < len(wave_mobs):
			$WaveTimer.start()
		else:
			get_tree().change_scene("res://Scenes/Win.tscn")

func _on_TextureButton_pressed():
	if building == false and money >= 25:
		instance = tower.instance()
		add_child(instance)
		building = true

func _on_TextureButton1_pressed():
	if building == false and money >= 50:
		instance = tower1.instance()
		add_child(instance)
		building = true

