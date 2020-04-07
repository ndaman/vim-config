; mouse keys for music
+XButton1::Send {Media_Prev}
; XButton2 = forward
+XButton2::Send {Media_Next}
; MButton
+MButton::Send {Media_Play_Pause}
; WheelUp
+WheelUp::Send {Volume_Up}
; WheelDown
+WheelDown::Send {Volume_Down}
; keyboard controls
; ctl + alt + key
^!Space::Send       {Media_Play_Pause}
^!Left::Send        {Media_Prev}
^!Right::Send       {Media_Next}
^!Up::Send					{Volume_Up}
^!Down::Send				{Volume_Down}
