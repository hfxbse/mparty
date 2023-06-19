extends Camera2D  

var last_pos
var target_pos = Vector2.ZERO
var vel = Vector2(0, 0) 
var is_moving = false  
var speed = 8 

func _ready():
	last_pos = position

func _input(event):  
	if is_current():  
		if event is InputEventMouseButton and event.button_mask == MOUSE_BUTTON_LEFT:#MOUSE_BUTTON_MASK_MIDDLE:  
			if event.pressed:
				last_pos = position
				target_pos = get_global_mouse_position()
				is_moving = true  
			else:  
				is_moving = false  

func _physics_process(delta):
	if (position - target_pos).length() < 3.0:
		is_moving = false
		target_pos = Vector2.ZERO
		vel = Vector2(0, 0)
		
	if is_moving:
		var newvel = target_pos
		newvel = newvel-position
		newvel = newvel.limit_length(speed)
		vel = vel.lerp(newvel, 0.2)
		position = position + vel		
		
func set_camera():
	position = last_pos
	make_current()
	
