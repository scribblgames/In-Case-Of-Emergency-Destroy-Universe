extends TextureButton

@export var Unit = preload ("res://Unit.tscn")

@export var Neighbors : Array[TextureButton]

@export var Swiss : bool

@export var occupied : bool

@export var value = 10

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
	UpdateMe()
	if occupied:
		SpawnUnit()
	
			
	pass # Replace with function body.

func DeleteUnit(tb : TextureButton):
	var children = tb.get_children()
	for child in children:
		child.free()

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

func UpdateMe():
	if not Swiss:
		modulate = Color.hex(0x6192ffff)
	else:
		modulate = Color.hex(0xfc5a00ff)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_pressed() -> void:
	#what the hell is this
	
	if Globals.Selected_Prov1 == self:
			Globals.Selected_Prov1 = null
	if Globals.Selected_Prov1 == null:
			Globals.Selected_Prov1 = self
	elif Globals.Selected_Prov2 == null and Globals.Selected_Prov1.Neighbors.has(self):
			Globals.Selected_Prov2 = self
	if not Globals.Selected_Prov2 == null and Globals.Selected_Prov2.Swiss and Globals.Selected_Prov2.occupied:
		Globals.Selected_Prov2 = null
		Globals.Selected_Prov1 = null
	if not Globals.Selected_Prov1 == null and Globals.Selected_Prov1.Swiss:
		Globals.Selected_Prov1 = null
	if not Globals.Selected_Prov2 == null:
		DeleteUnit(Globals.Selected_Prov1)
		Globals.Selected_Prov2.occupied = true
		Globals.Selected_Prov1.occupied = false
		Globals.Selected_Prov2.Swiss = false
		Globals.Selected_Prov1 = null
		Globals.Selected_Prov2 = null
		UpdateMe()
		SpawnUnit()
	
	pass # Replace with function body.
