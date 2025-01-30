extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saveAndLoad.new().loadData()
	GLOBAL.isInspideOfEliment = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_startup_dialoge_confirmed() -> void:
	GLOBAL.isInspideOfEliment = false


func _on_startup_dialoge_canceled() -> void:
	GLOBAL.isInspideOfEliment = false
