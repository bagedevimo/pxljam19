extends RichTextLabel

func play_speech(txt):
	text = txt
	$AnimationPlayer.play("Speak")
