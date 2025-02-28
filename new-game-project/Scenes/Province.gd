extends TextureButton

@export var Unit = preload ("res://Unit.tscn")

@export var Neighbors : Array[TextureButton]

@export var Swiss : bool

@export var occupied : bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the image from the texture normal
	var image = texture_normal.get_image()
	# Create the BitMap
	var bitmap = BitMap.new()
	# Fill it from the image alpha
	bitmap.create_from_image_alpha(image)
	# Assign it to the mask
	texture_click_mask = bitmap
	
	if occupied:
		SpawnUnit()
	
			
	pass # Replace with function body.



func SpawnUnit():
	var instance = Unit.instantiate()
	add_child(instance)
	instance.global_position = global_position + Vector2(size.x / 2, size.y / 2)
	if not Swiss:
		instance.modulate = Color.hex(0x6192ffff)
	else:
		instance.modulate = Color.hex(0xfc5a00ff)
	#instance.reparent()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_pressed() -> void:
	modulate = Color(0, 0, 0)
	pass # Replace with function body.
