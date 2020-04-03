#InstallKeybdHook
SetCapsLockState, 
+CapsLock::
SetCapsLockState % !GetKeyState("CapsLock", "T")
return
