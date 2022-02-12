#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Include, libraries/Class_ImageButton.ahk
#Include libraries/UseGDIP.ahk

PrimaryButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFFFDA858", "0xFFFDA858", "White", "H", , , 4] 
Opt2 := [1, "0xFFFCD6B3", "0xFFFCD6B3", "White", "H", , , 4]
Opt3 := [1, "0xFFFFD13A", "0xFFFFD13A", "White", "H", , , 4]
Opt4 := [1, "0xFFFDA858", "0xFFFDA858", "White", "H", , , 4]
Opt5 := [1, "0xFFFDA858", "0xFFFDA858", "White", "H", , , 4]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

SecondaryButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var2% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFFF3EA", "0xFFF3EA", "Black", "9", , "0xFDB572", 1] 
Opt2 := [1, "0xFFFCD6B3", "0xFFFCD6B3", "White", "9", , "0xFDB572", 1]
Opt3 := [1, "0xFFFFD13A", "0xFFFFD13A", "White", "9", , "0xFDB572", 1]
Opt4 := [1, "0xFFFDA858", "0xFFFDA858", "White", "9", , "0xFDB572", 1]
Opt5 := [1, "0xFFFDA858", "0xFFFDA858", "White", "9", , "0xFDB572", 1]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

ThirdButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var3% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xB7A1A9", "0xB7A1A9", "White", "H", , "0x8D7083", 2] 
Opt2 := [1, "0xCEB5BE", "0xCEB5BE", "White", "H", , "0x8D7083", 2]
Opt3 := [1, "0x96848B", "0x96848B", "White", "H", , "0x8D7083", 2]
Opt4 := [1, "0xB7A1A9", "0xB7A1A9", "White", "H", , "0x8D7083", 2]
Opt5 := [1, "0xB7A1A9", "0xB7A1A9", "White", "H", , "0x8D7083", 2]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

FourthButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFFF3EA", "0xFFF3EA", "0x8D7083", "H", , "0x8D7083", 2] 
Opt2 := [1, "0xFCD5B0", "0xFCD5B0", "0x573353", "H", , "0x573353", 2]
Opt3 := [1, "0xFFF3EA", "0xFFF3EA", "0x8D7083", "H", , "0x8D7083", 2]
Opt4 := [1, "0xFFF3EA", "0xFFF3EA", "0x8D7083", "H", , "0x8D7083", 2]
Opt5 := [1, "0xFFF3EA", "0xFFF3EA", "0x8D7083", "H", , "0x8D7083", 2]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

FifthButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFCAE64", "0xFCAE64", "0x573353", "H", , , 4] 
Opt2 := [1, "0xFFFCD6B3", "0xFFFCD6B3", "0x573353", "H", , 0x573353, 1]
Opt3 := [1, "0xFFFFD13A", "0xFFFFD13A", "0x573353", "H", , , 4]
Opt4 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
Opt5 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

SixthButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFCB471", "0xFCB471", "0x573353", "H", , , 4] 
Opt2 := [1, "0xFFFCD6B3", "0xFFFCD6B3", "0x573353", "H", , 0x573353, 1]
Opt3 := [1, "0xFFFFD13A", "0xFFFFD13A", "0x573353", "H", , , 4]
Opt4 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
Opt5 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

SeventhButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFCC897", "0xFCC897", "0x573353", "H", , , 4] 
Opt2 := [1, "0xFFFCD6B3", "0xFFFCD6B3", "0x573353", "H", , 0x573353, 1]
Opt3 := [1, "0xFFFFD13A", "0xFFFFD13A", "0x573353", "H", , , 4]
Opt4 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
Opt5 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

EigthButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFCCEA4", "0xFCCEA4", "0x573353", "H", , , 4] 
Opt2 := [1, "0xFFFCD6B3", "0xFFFCD6B3", "0x573353", "H", , 0x573353, 1]
Opt3 := [1, "0xFFFFD13A", "0xFFFFD13A", "0x573353", "H", , , 4]
Opt4 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
Opt5 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

NinthButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFCD5B0", "0xFCD5B0", "0x573353", "H", , , 4] 
Opt2 := [1, "0xFFFCD6B3", "0xFFFCD6B3", "0x573353", "H", , 0x573353, 1]
Opt3 := [1, "0xFFFFD13A", "0xFFFFD13A", "0x573353", "H", , , 4]
Opt4 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
Opt5 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}

TenthButton(label,hwndvar,text,xpos,ypos,wid,hei) {
Gui, Add, Button, g%label% v%var% hwnd%hwndvar% x%xpos% y%ypos% w%wid% h%hei%, %text%
Opt1 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4] 
Opt2 := [1, "0xFFFCD6B3", "0xFFFCD6B3", "0x573353", "H", , 0x573353, 1]
Opt3 := [1, "0xFFFFD13A", "0xFFFFD13A", "0x573353", "H", , , 4]
Opt4 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
Opt5 := [1, "0xFFFDA858", "0xFFFDA858", "0x573353", "H", , , 4]
If !ImageButton.Create(%hwndvar%, Opt1, Opt2, , , Opt5)
   MsgBox, 0, ImageButton Error Btn1, % ImageButton.LastError
    return
}