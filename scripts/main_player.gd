extends CharacterBody2D

class_name mainPlayer

@onready var progressBar = $health_progress

var gravity : float = GLOBAL.gravity
var jumpForce : float = GLOBAL.jumpForce
var horizontalSpeed : float = GLOBAL.horizontalSpeed

var acc = GLOBAL.acc
var fullCapacity = false

signal moveCamera(cameraX,cameraY)

signal activateLazer(strength)
signal deactivateLazer()

signal zoomCamera(posX,posY,zoomAmount)
signal resetCamera()

signal loopPlayer()


func _ready() -> void:
	Engine.set_time_scale(1)


func _physics_process(delta: float) -> void:
	
	$Control/VBoxContainer/Label.text = str(GLOBAL.shotMultiplyer)
	
	attackHandleing()
		
	progressBar.value = GLOBAL.progress
	
	gravity = GLOBAL.gravity
	jumpForce = GLOBAL.jumpForce
	horizontalSpeed = GLOBAL.horizontalSpeed

	acc = GLOBAL.acc
	
	GLOBAL.playerPosX = position.x
	GLOBAL.playerPosY = position.y
	
	
	movement(delta)


func _on_col_detection_area_entered(area: Area2D) -> void:
	
	if area.is_in_group("shoping and other area"):
		print("lets go shoping bae")
		emit_signal("moveCamera",0,-756)
		print("788")
	
	if area.is_in_group("fighting area"):
		print("fighting area enterd")
		emit_signal("moveCamera",0,0)
		
	
	var othersideTeleportXpos = 655
	if area.is_in_group("left looping"):
		var prevPosY = position.y
		#print("left looping")
		position = Vector2(othersideTeleportXpos,prevPosY)
		emit_signal("loopPlayer")
		
		for x in 100:
			velocity.x = max(velocity.x - acc, -horizontalSpeed)
			
	elif area.is_in_group("right looping"):
		var prevPosY = position.y
		#print("right looping")
		position = Vector2(-othersideTeleportXpos,prevPosY)
		emit_signal("loopPlayer")
		
		for x in 100:
			velocity.x = min(velocity.x + acc, horizontalSpeed)
		
func movement(delta):
	
	if Input.is_action_pressed("left"):
		#print(velocity.x)
		velocity.x = max(velocity.x - acc, -horizontalSpeed)
		#print(position)
		#print("... ---")
		#print(GLOBAL.playerPosX + GLOBAL.playerPosY)
	elif Input.is_action_pressed("right"):
		#print(velocity.x)
		velocity.x = min(velocity.x + acc, horizontalSpeed)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.01)
		
	
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump"):
			velocity.y = -jumpForce
		
	move_and_slide()
	
func attackHandleing():
	
	if Input.is_action_pressed("atack") and GLOBAL.progress > 1 and !GLOBAL.isInspideOfEliment:
		if GLOBAL.progress >= 93 or fullCapacity:
			fullCapacity = true
			SlowTIME(0.2)
			emit_signal("activateLazer",100)
			emit_signal("zoomCamera",position.x,position.y,0.3)
		else:
			SlowTIME(0.4)
			emit_signal("activateLazer",100)
			emit_signal("zoomCamera",position.x,position.y,0.1)
	else:
		SlowTIME(1)
		emit_signal("deactivateLazer")
		emit_signal("resetCamera")
		fullCapacity = false
			
	


func SlowTIME(slowTime):
	Engine.set_time_scale(slowTime)
	

func _on_increase_progress_timeout() -> void:
	if GLOBAL.progress < 101:
		GLOBAL.progress += 10
		#print(GLOBAL.progress)
