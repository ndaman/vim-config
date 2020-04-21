; 1. check for vlc, send keys if it exists
; https://gist.github.com/vaindil/a223fe82ec2122e02bf0062c82a20186
; 2. check for amazon music tab, send keys if it exists
; 3. check for youtube music tab, send keys if it exists
; 4. check for spotify tab, send keys if it exists
; 5. send global media key otherwise
; global media keys were not working in VLC, so I switched to controlsend

; library for getting tab names
#Include firefox_youtube_media_keys.ahk 

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

; these work globally
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
	HandleKey("p")
}

next()
{if WinExist("ahk_exe vlc.exe")
	{
	vlc_id := WinExist("ahk_exe vlc.exe")
	ControlSend,,n,ahk_id %vlc_id%
	}
else
	HandleKey("n")
}

playPause()
{if WinExist("ahk_exe vlc.exe")
	{
	vlc_id := WinExist("ahk_exe vlc.exe")
	ControlSend,,{Space},ahk_id %vlc_id%
	}
else
	HandleKey("s")
}
