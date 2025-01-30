extends Node

class_name saveAndLoad

var savePath = "user://FAattassTESTINGhOES.save"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func save():
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	file.store_var(GLOBAL.gravity)         
	file.store_var(GLOBAL.jumpForce)      
	file.store_var(GLOBAL.horizontalSpeed)
	file.store_var(GLOBAL.acc)             
	file.store_var(GLOBAL.progress)
	file.store_var(GLOBAL.playerPosX)
	file.store_var(GLOBAL.playerPosY)
	file.store_var(GLOBAL.stage)
	file.store_var(GLOBAL.strength)
	
	print("data saved")    
	
func loadData():
	if FileAccess.file_exists(savePath):
		var file = FileAccess.open(savePath, FileAccess.READ)
		GLOBAL.gravity = file.get_var(GLOBAL.gravity)
		GLOBAL.jumpForce = file.get_var(GLOBAL.jumpForce)
		GLOBAL.horizontalSpeed = file.get_var(GLOBAL.horizontalSpeed)
		GLOBAL.acc = file.get_var(GLOBAL.acc)
		GLOBAL.progress = file.get_var(GLOBAL.progress)
		GLOBAL.stage = file.get_var(GLOBAL.stage)
		GLOBAL.playerPosX = file.get_var(GLOBAL.playerPosY)
		GLOBAL.playerPosY = file.get_var(GLOBAL.playerPosY)
		GLOBAL.strength = file.get_var(GLOBAL.strength)
		
		
	else:
		print("no data saved...")
		resetData()

		
func resetData():
	GLOBAL.gravity = 1100
	GLOBAL.jumpForce = 550
	GLOBAL.horizontalSpeed = 500
	GLOBAL.acc = 60
	GLOBAL.progress = 12.5
	GLOBAL.playerPosX = 0
	GLOBAL.playerPosY = 0
	GLOBAL.stage = 0
	GLOBAL.strength = 1
		
		
		
