#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
FormatTime, Current, yyyyMMddHHmmss 

   FileReadLine, toLearn, toLearn.txt, 2
          if (ErrorLevel = 1) {
Loop, read, qStat.txt
{
questionStats := StrSplit(A_LoopReadLine, "_")
toCompare := questionStats[2]
if (toCompare <= Current) {
    MsgBox, , Minerva, You have outstanding questions in your Quiz Queue!, 3
break
    }
}
          } else {
MsgBox, , Minerva, You have outstanding items in your Learning Queue!, 3

          }


;Alt Shift c
!+c::
Send ^c
clipboard := clipboard 
sleep 100
;MsgBox, %clipboard%
FileAppend, %clipboard% `n, toLearn.txt
MsgBox, , Minerva, Added to Learning Queue!, .4
return
