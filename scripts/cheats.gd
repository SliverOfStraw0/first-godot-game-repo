extends Control

#if true at start will display cheet menue at start. if flase the menue will hide
var cheatIsPressed = false

var player = mainPlayer.new()

var snl = saveAndLoad.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide() #show if u want to be on on start
	snl.loadData()
	changeSlideVarVals()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MarginContainer/VBoxContainer/gravity/number.text = str($"MarginContainer/VBoxContainer/gravity/gravity slider".value)
	$"MarginContainer/VBoxContainer/jump force/number".text = str($"MarginContainer/VBoxContainer/jump force/HSlider".value)
	$"MarginContainer/VBoxContainer/max speed/number".text = str($"MarginContainer/VBoxContainer/max speed/HSlider".value)
	$MarginContainer/VBoxContainer/accelaration/number.text = str($MarginContainer/VBoxContainer/accelaration/HSlider.value)
	$MarginContainer/VBoxContainer/strength/number.text = str($MarginContainer/VBoxContainer/strength/HSlider.value)
	
	
	#print(cheatIsPressed)
	if Input.is_action_just_pressed("cheat"):
		if cheatIsPressed:
			cheatclosed()
			cheatIsPressed = false
		elif !cheatIsPressed:
			cheatPressed()
			cheatIsPressed = true
			
	

			

func changeVarSlider():
	GLOBAL.gravity = $"MarginContainer/VBoxContainer/gravity/gravity slider".value
	GLOBAL.jumpForce = $"MarginContainer/VBoxContainer/jump force/HSlider".value
	GLOBAL.horizontalSpeed = $"MarginContainer/VBoxContainer/max speed/HSlider".value
	GLOBAL.acc = $MarginContainer/VBoxContainer/accelaration/HSlider.value
	GLOBAL.strength = $MarginContainer/VBoxContainer/strength/HSlider.value
	
func changeSlideVarVals():
	$"MarginContainer/VBoxContainer/gravity/gravity slider".value = GLOBAL.gravity
	$"MarginContainer/VBoxContainer/jump force/HSlider".value = GLOBAL.jumpForce
	$"MarginContainer/VBoxContainer/max speed/HSlider".value = GLOBAL.horizontalSpeed
	$MarginContainer/VBoxContainer/accelaration/HSlider.value = GLOBAL.acc
	$MarginContainer/VBoxContainer/strength/HSlider.value = GLOBAL.strength

func cheatPressed():
	GLOBAL.isInspideOfEliment = true
	show()
	changeSlideVarVals()

func cheatclosed():
	GLOBAL.isInspideOfEliment = false
	hide()
	changeVarSlider()
	snl.save()

func _on_margin_container_mouse_entered() -> void:
	pass


func _on_margin_container_mouse_exited() -> void:
	pass


func _on_reset_pressed() -> void:
	snl.resetData()
	
	changeSlideVarVals()
	

func _on_max_health_pressed() -> void:
	GLOBAL.progress = 100


func _on_update_pressed() -> void:
	changeVarSlider()
	snl.save()
