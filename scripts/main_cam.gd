extends Camera2D

@export var randomestrength = 10
var shakefade = 5

var rng = RandomNumberGenerator.new()

var shakeStrength = 0


var defultZoom = 0.5

var zX
var zy

var oneTimeZoom = true

var WTFFF = false

@export var moveTwordsSpped = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position_smoothing_speed = moveTwordsSpped
	
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength,0,shakefade * delta)
		
	offset = randomeoffset()


func _on_main_player_move_camera(cameraX: Variant, cameraY: Variant) -> void:
	position = Vector2(cameraX,cameraY)
	#print(position)
	
	
func setCameraToNormal():
	if !oneTimeZoom:
		oneTimeZoom = true
		applayShake()
		var tween = create_tween()
		tween.tween_property(self,"zoom",Vector2(defultZoom,defultZoom),0.3)
		
		tween.tween_property(self,"position",Vector2(0,0),0.2)
		
		#print("AAA")



func zoomCamera(posX,posY,zoomAmount):
	WTFFF = true
	
	if oneTimeZoom:
		regCamSmothingMOvement()
		oneTimeZoom = false
		
	position.x = posX
	
	
	zoom.x += zoomAmount * get_process_delta_time()
	zoom.y += zoomAmount * get_process_delta_time()
	


func _on_main_player_zoom_camera(posX: Variant, posY: Variant, zoomAmount: Variant) -> void:
	zoomCamera(posX,posY,zoomAmount)


func _on_main_player_reset_camera() -> void:
	setCameraToNormal()
	WTFFF = false
	
func applayShake():
	shakeStrength = randomestrength
	
func randomeoffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStrength,shakeStrength),rng.randf_range(-shakeStrength,shakeStrength))
	


func _on_main_player_loop_player() -> void:
	print("LOOPING")
	moveTwordsSpped = 6
	$"loop timer".start()

func regCamSmothingMOvement():
		moveTwordsSpped = 3
		
func _on_loop_timer_timeout() -> void:
	regCamSmothingMOvement()
	print("TIMER TIMEOUTT")
