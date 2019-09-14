extends KinematicBody2D

# This is a demo showing how KinematicBody2D
# move_and_slide works.

# Member variables
const MOTION_SPEED = 360 # Pixels/second

var focus = null

func _process(delta):
	if Input.is_action_just_released("ui_select"):
		if self.focus && self.focus.has_method("interact"):
			self.focus.interact();

func _ready():
	EventBus.register_listener(self, "before_death")

func handle_before_death(args):
	print("I'm dying here...", args)

func _physics_process(delta):
	var motion = Vector2()

	if Input.is_action_pressed("ui_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		motion += Vector2(0, 1)
	if Input.is_action_pressed("ui_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		motion += Vector2(1, 0)
	
	motion = motion.normalized() * MOTION_SPEED

	return move_and_slide(motion)

func set_focus(target):
	self.focus = target

func clear_focus_where(target):
	if self.focus == target:
		self.focus = null
