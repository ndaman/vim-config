; This script requires the Acc.ahk standard library. You can get it (and this script) from the link below.
; https://gist.github.com/vaindil/a223fe82ec2122e02bf0062c82a20186
#Include Acc.ahk

;p n s are the keys sent
HandleKey(Key) {
  WinGet FF, ID, ahk_exe firefox.exe
  Tabs := JEE_FirefoxGetTabNames(FF)
  WinGetTitle, CurrentTitle, ahk_id %FF%
  SubstrPos := InStr(CurrentTitle, " - Mozilla Firefox")
  CurrentTitle := SubStr(CurrentTitle, 1, SubstrPos - 1)
  TabName = ""

  Loop, Parse, Tabs, `n
  {
    If (RegexMatch(A_LoopField, "Spotify.*")) {
      TabName := A_LoopField
			If (Key == "p")
				newKey := "a"
			Else If (Key == "n")
				newKey := "d"
			Else If (Key == "s")
				newKey := "s"
      break
    }
    Else If (RegexMatch(A_LoopField, "Amazon Music")) {
      TabName := A_LoopField
			If (Key == "p")
				newKey := "Left"
			Else If (Key == "n")
				newKey := "Right"
			Else If (Key == "s")
				newKey := "Space"
      break
    }
	  Else If (RegexMatch(A_LoopField, ".*YouTube Music")) {
      TabName := A_LoopField
			If (Key == "p")
				newKey := "k"
			Else If (Key == "n")
				newKey := "j"
			Else If (Key == "s")
				newKey := "Space"
      break
    }
	}

  If (TabName = "") {
    return
  }

  JEE_FirefoxFocusTabByName(FF, TabName)
  Sleep 200
	ff_id := WinExist("ahk_exe firefox.exe")
  ControlSend, ahk_parent , {%newKey%}, ahk_id %ff_id%
	Sleep 200
  JEE_FirefoxFocusTabByName(FF, CurrentTitle)
}

; https://autohotkey.com/boards/viewtopic.php?f=6&t=26947&p=139114#p139114

JEE_FirefoxGetTabNames(hWnd, vSep:="`n")
{
  oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
  vRet := 0
  for _, oChild in Acc_Children(oAcc)
    if (oChild.accName(0) == "Browser tabs")
    {
      oAcc := Acc_Children(oChild)[1], vRet := 1
      break
    }
  if !vRet
  {
    oAcc := oChild := ""
    return
  }

  vOutput := ""
  for _, oChild in Acc_Children(oAcc)
  {
    vTabText := oChild.accName(0)
    if !(vTabText == "")
    ;&& !(vTabText == "New Tab")
    ;&& !(vTabText == "Open a new tab")
      vOutput .= vTabText vSep
  }
  vOutput := SubStr(vOutput, 1, -StrLen(vSep)) ;trim right
  oAcc := oChild := ""
  return vOutput
}

JEE_FirefoxFocusTabByName(hWnd, vTitle, vNum:=1)
{
  oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
  vRet := 0
  for _, oChild in Acc_Children(oAcc)
    if (oChild.accName(0) == "Browser tabs")
    {
      oAcc := Acc_Children(oChild)[1], vRet := 1
      break
    }
  if !vRet
  {
    oAcc := oChild := ""
    return
  }

  vCount := 0, vRet := 0
  for _, oChild in Acc_Children(oAcc)
  {
    vTabText := oChild.accName(0)
    if (vTabText = vTitle)
      vCount++
    if (vCount = vNum)
    {
      oChild.accDoDefaultAction(0), vRet := A_Index
      break
    }
  }
  oAcc := oChild := ""
  return vRet
}
