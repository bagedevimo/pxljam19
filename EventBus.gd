extends Node

var events = {}

func trigger_event(event_name, args):
	for listener in events[event_name]:
		listener.call("handle_" + event_name, args)

func register_listener(listener, event_name):
	if !events.has(event_name):
		events[event_name] = []

	if events[event_name].find(event_name) != -1:
		return

	events[event_name].append(listener)