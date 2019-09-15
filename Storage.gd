# Usage:
# $Storage.store("logs", 10)
# 
# $Storage.has("logs") // true
# $Storage.has("logs", 12) // false
# $Storage.has("logs", 5) // true
#
# $Storage.retrieve("logs", 4) // 4
# $Storage.retrieve("logs", 7) // false
# $Storage.retrieve("logs") // 6

extends Node2D

var storage = {}

func store(key, amount):
	#print("Storing ", key, " (", amount, ")")
	if !storage.has(key):
		storage[key] = amount
	else:
		storage[key] += amount

func retrieve(key, amount = null):
	if !has(key, amount):
		return false

	if amount == null:
		var everything = storage[key]
		storage[key] = 0
		return  everything

	storage[key] -= amount
	return amount

func has(key, amount = null):
	if !storage.has(key):
		return false

	if amount == null:
		return true

	if storage[key] < amount:
		return false
	else:
		return true
		
func quantity(key):
	if !storage.has(key):
		return 0
		
	return storage[key]