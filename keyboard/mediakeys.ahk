; global media keys were not working in VLC, so I switched to controlsend

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
{if WinExist("ahk_exe vlc.exe")
	vlc_id := WinExist("ahk_exe vlc.exe")
ControlSend,,p,ahk_id %vlc_id%
}

next()
{if WinExist("ahk_exe vlc.exe")
	vlc_id := WinExist("ahk_exe vlc.exe")
ControlSend,,n,ahk_id %vlc_id%
}

playPause()
{if WinExist("ahk_exe vlc.exe")
	vlc_id := WinExist("ahk_exe vlc.exe")
ControlSend,,{Space},ahk_id %vlc_id%
}
