extends Node2D

var savenload = saveAndLoad.new()

@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		savenload.save()


func _on_timer_timeout() -> void:
	print("...")
	savenload.save()
	print("...")
	timer.start()
