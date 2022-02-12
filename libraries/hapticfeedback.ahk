#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

;DEBUG
;RButton::
;HapticFunc("NextTime.png","DontGiveUp.png")
;return


HapticFunc(Choices*) {
    Random,Index,1,% Choices.MaxIndex()
CoordMode, Mouse, Screen
MouseGetPos, xpos, ypos 
ypos := ypos-23
Gui, haptic: +AlwaysOnTop +LastFound -Caption +E0x20
Gui, haptic: Color,FFFFFF
WinSet,Transcolor, FFFFFF 
image := Choices[Index]
Gui, haptic: Add,Pic,,assets/%image%
Gui, haptic: Show, x%xpos% y%ypos%
sleep 400
Gui, haptic: Destroy
return
}

