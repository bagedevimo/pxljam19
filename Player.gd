extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 360 # Pixels/second

var focus = null

export (int) var life_expectancy = 55
export (int) var year_in_seconds = 10

var previous_age = 0
var seconds_alive = 0

func _ready():
	EventBus.register_listener(self, EventBus.ON_DEATH)
	EventBus.register_listener(self, EventBus.ON_BIRTH)

	EventBus.trigger_event(EventBus.ON_BIRTH)

func _process(delta):
	if Input.is_action_just_released("ui_select"):
		if self.focus && self.focus.has_method("interact"):
			self.focus.interact(self);

	seconds_alive += delta

	if age() != previous_age:
		previous_age = age()
		print("I'm ", previous_age, " years old now")

	if age() >= life_expectancy:
		rebirth()

func age():
	return floor(seconds_alive / year_in_seconds)

func rebirth():
	print("in rebirth()")
	# ON_BIRTH is going to be trigger by animation change from ON_DEATH
	EventBus.trigger_event(EventBus.ON_DEATH)

func handle_on_death(args):
	print("I'm dying....", args)
	face_east()
	$AnimationPlayer.play("Death")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Death":
		EventBus.trigger_event(EventBus.ON_BIRTH)

func handle_on_birth(args):
	print("I'm reborn....", args)
	position = get_node("../StartingPosition").position
	$Sprite.rotation_degrees = 0
	seconds_alive = 0
	$AnimationPlayer.play("Birth")

func _physics_process(delta):
	var motion = Vector2()

	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0, -1)
		face_north()
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0, 1)
		face_south()
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
		face_west()
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
		face_east()
	if Input.is_action_just_pressed("debug_rebirth"):
		rebirth()
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)
	
	position.x = clamp(position.x, $Camera2D.limit_left, $Camera2D.limit_right)
	position.y = clamp(position.y, $Camera2D.limit_top,  $Camera2D.limit_bottom)

func set_focus(target):
	self.focus = target

func clear_focus_where(target):
	if self.focus == target:
		self.focus = null

func face_east():
	$Sprite.region_rect.position.x = 0

func face_west():
	$Sprite.region_rect.position.x = 32

func face_north():
	$Sprite.region_rect.position.x = 64

func face_south():
	$Sprite.region_rect.position.x = 96