extends Node

const ON_DEATH = "on_death"
const ON_BIRTH = "on_birth"

var events = {}

func trigger_event(event_name, args = null):
	if !events.has(event_name):
		return

	for listener in events[event_name]:
		listener.call("handle_" + event_name, args)

func register_listener(listener, event_name):
	if !events.has(event_name):
		events[event_name] = []

	if events[event_name].find(event_name) != -1:
		return

	events[event_name].append(listener)