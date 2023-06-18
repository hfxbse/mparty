extends TextureButton

var picked_signal

func activate(callback_signal):
	show()
	picked_signal = callback_signal
	
func deactivate():
	hide()
	picked_signal = null
	
func _pressed():
	picked_signal.emit()
