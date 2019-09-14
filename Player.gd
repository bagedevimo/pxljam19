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

func _process(delta):
	if Input.is_action_just_released("ui_select"):
		if self.focus && self.focus.has_method("interact"):
			self.focus.interact();

	seconds_alive += delta

	if age() != previous_age:
		previous_age = age()
		print("I'm ", previous_age, " years old now")

	if age() >= life_expectancy:
		EventBus.trigger_event(EventBus.BEFORE_DEATH, self)
		EventBus.trigger_event(EventBus.ON_DEATH, self)
		EventBus.trigger_event(EventBus.AFTER_DEATH, self)

func age():
	return floor(seconds_alive / year_in_seconds)

func _ready():		
	EventBus.register_listener(self, EventBus.BEFORE_DEATH)

func handle_before_death(args):
	print("I'm dying here...", args)
	seconds_alive = 0
	print("I'm reborn....", args)

func _physics_process(delta):
	var motion = Vector2()

	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0, -1)
		$Sprite.region_rect.position.x = 64
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0, 1)
		$Sprite.region_rect.position.x = 96
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
		$Sprite.region_rect.position.x = 32
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
		$Sprite.region_rect.position.x = 0
	
	motion = motion.normalized() * MOTION_SPEED

	move_and_slide(motion)
	
	position.x = clamp(position.x, $Camera2D.limit_left, $Camera2D.limit_right)
	position.y = clamp(position.y, $Camera2D.limit_top,  $Camera2D.limit_bottom)

func set_focus(target):
	self.focus = target

func clear_focus_where(target):
	if self.focus == target:
		self.focus = null
