; 1. check for vlc, send keys if it exists
; https://gist.github.com/vaindil/a223fe82ec2122e02bf0062c82a20186
; 2. send global media key otherwise
; global media keys were not working in VLC, so I switched to controlsend

; mouse keys for music
+XButton1::
	prev()
return
; XButton2 = forward
+XButton2::
	next()
return
; MButton
+MButton::
	playPause()
return

; these work globally
; WheelUp
+WheelUp::Send {Volume_Up}
; WheelDown
+WheelDown::Send {Volume_Down}

; keyboard controls
; ctl + alt + key
^!Space::
	playPause()
return
^!Left::
	prev()
return
^!Right::
	next()
return

;these work globally
^!Up::Send					{Volume_Up}
^!Down::Send				{Volume_Down}

; controlsend commands
prev()
{
if WinExist("ahk_exe vlc.exe")
	{
	vlc_id := WinExist("ahk_exe vlc.exe")
	ControlSend,,p,ahk_id %vlc_id%
	}
else 
	Send {Media_Prev}
}

next()
{if WinExist("ahk_exe vlc.exe")
	{
	vlc_id := WinExist("ahk_exe vlc.exe")
	ControlSend,,n,ahk_id %vlc_id%
	}
else
	Send {Media_Next}
}

playPause()
{if WinExist("ahk_exe vlc.exe")
	{
	vlc_id := WinExist("ahk_exe vlc.exe")
	ControlSend,,{Space},ahk_id %vlc_id%
	}
else
	Send {Media_Play_Pause}
}
