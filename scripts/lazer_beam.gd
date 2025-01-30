extends RayCast2D

var activateTween = false
var lazerColBodies

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GLOBAL.lazerActiveState:
		workLazer()
		detectColidingBodys()
	
func getLazerColBodies():
	lazerColBodies = get_collider()
	#print(lazerColBodies)
	if lazerColBodies != null:
		if lazerColBodies.is_in_group("enemy"):
			updateColBodies(lazerColBodies)

func updateColBodies(body):
	GLOBAL.finalShot = ((GLOBAL.strength * GLOBAL.shotMultiplyer) + GLOBAL.progress / 2 ) / 10
	if body.health > 0:
		body.health -= GLOBAL.finalShot 
		#print(body.health)
		print(GLOBAL.finalShot)

		
func workLazer():
	var mousePos
	var hitingPos
	GLOBAL.progress -= 0.5
	GLOBAL.shotMultiplyer += 0.1
	
	mousePos = Vector2(get_local_mouse_position().x - position.x,get_local_mouse_position().y - position.y)
	hitingPos = Vector2($RayCast2D.get_collision_point().x - GLOBAL.playerPosX,$RayCast2D.get_collision_point().y - GLOBAL.playerPosY)
	$RayCast2D.target_position = mousePos
	
	$Line2D.clear_points()
	if $RayCast2D.is_colliding():
		getLazerColBodies()
		target_position = hitingPos
		$Line2D.add_point(Vector2(0,0))
		$Line2D.add_point(hitingPos)
	else:
		target_position = mousePos
		$Line2D.add_point(Vector2(0,0))
		$Line2D.add_point(mousePos)
			
func tweenLazer():
	var tween = create_tween()
	$Line2D.width = 4
	tween.tween_property($Line2D,"width",20,0.2)

func detectColidingBodys():
	var body = get_collider()
	#print(get_collider())

func activateLazer():
	show()
	GLOBAL.lazerActiveState = true
	if activateTween:
		activateTween = false
		tweenLazer()
		#print("TWEENING")

func deactivate():
	hide()
	GLOBAL.lazerActiveState = false
	activateTween = true
	GLOBAL.shotMultiplyer = 0

func _on_main_player_activate_lazer(strength: Variant) -> void:
	activateLazer()
	#print("active")
	tweenLazer()
	


func _on_main_player_deactivate_lazer() -> void:
	deactivate()
