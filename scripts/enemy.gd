extends CharacterBody2D

@export_category("stats")
@export_group("atack")

@export var health = 1000
@export var atackDamage = 1

@export_group("movement")
@export var speed = 100
@export var mode = 0


@export_category("hardCodedEnemySelector")

@export var enemyType: String = "basic"

var enemyName: String
var healthAtStart 

# health, atackDamage, speed, mode
var enemyTypeNames = {
	basic = [50,1,100,0], 
Aadvanced = [200, 1.5, 120, 0],
Badvanced = [600,2,80,0],
ShitforTesting = [2000000,2,80,0]}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var y = -1
	for x in enemyTypeNames:
		y += 1
		#print(x)
		if enemyType == str(x):
			#print(enemyTypeNames.values()[y])
			var theShit = enemyTypeNames.values()[y]
			setValsToProper(theShit[0],theShit[1],theShit[2],theShit[3],x)

func setValsToProper(H,A,S,M,nam):
	health = H
	#healthAtStart = health
	atackDamage = A
	speed = S
	mode = M
	enemyName = nam

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health < 0:
		hide()
		#GLOBAL.progress += healthAtStart / 10


func _on_test_dummy_area_entered(area: Area2D) -> void:
	if area.is_in_group("lazerBeam"):
		print("LAZER BEAM")
