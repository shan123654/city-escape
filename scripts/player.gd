extends CharacterBody3D

@export var speed: float = 5.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = input_direction.x * speed
	velocity.z = input_direction.y * speed
	move_and_slide()
