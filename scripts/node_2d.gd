extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saveAndLoad.new().loadData()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_timer_timeout() -> void:
	$Timer.start()
	$TextureProgressBar.value += 1
