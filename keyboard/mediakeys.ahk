; global media keys were not working in VLC, so I switched to controlsend
SetTitleMatchMode, 2

; mouse keys for music
+XButton1::
	Send {Media_Prev}
	prev()
return
; XButton2 = forward
+XButton2::
	Send {Media_Next}
	next()
return
; MButton
+MButton::
	Send {Media_Play_Pause}
	playPause()
return
; WheelUp
+WheelUp::Send {Volume_Up}
; WheelDown
+WheelDown::Send {Volume_Down}

; keyboard controls
; ctl + alt + key
^!Space::
	Send {Media_Play_Pause}
	playPause()
return
^!Left::
	Send {Media_Prev}
	prev()
return
^!Right::
	Send {Media_Next}
	next()
return
^!Up::Send					{Volume_Up}
^!Down::Send				{Volume_Down}

; controlsend commands
prev()
{ControlSend,,p,VLC}

next()
{ControlSend,,n,VLC}

playPause()
{ControlSend,,Space,VLC}
