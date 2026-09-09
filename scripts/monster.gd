extends CharacterBody3D

@export var speed: float = 3.0
@export var target: Node3D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Vector3.ZERO
	if is_instance_valid(target):
		direction = target.global_position - global_position
		direction.y = 0.0
		direction = direction.normalized()

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	move_and_slide()

	for index in range(get_slide_collision_count()):
		if get_slide_collision(index).get_collider() == target and is_instance_valid(target):
			if target.has_method("die"):
				set_physics_process(false)
				target.call("die")
				return
