#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#Include, libraries/Class_ImageButton.ahk
#Include libraries/UseGDIP.ahk
#Include libraries/styleGuide.ahk
lineNo = 0


FileRead, NewToLearn, toLearn.txt
Gui, New, , Minerva - Quiz Builder
Gui, Add, Picture, x0 y0 , assets/QuizBuilder.png
Gui, Add, Text, x10 y80 vToLearn w370 h200, 
Gui, Submit, NoHide
Gui, Add, Picture, x10 y510 vVimp gVImport, assets/vimportunse.png
;Gui, Add, Button, gVImport, Very Important
Gui, Add, Picture, x150 y510 vImp gImport, assets/importunse.png
;Gui, Add, Button, gImport, Important
Gui, Add, Picture, x250 y510 vLimp gLImport, assets/limportunse.png
;Gui, Add, Button, gLImport, Less Important
;Gui, Add, Picture, x331 y591 gSaveNExit, next.png
ThirdButton("SaveNExit","HBT1","Next","321","587","50","30")
;Gui, Add, Button, gSaveNExit, Save + Next
;Gui, Add, Picture, x160 y581 gSaveNNew, add.png
PrimaryButton("SaveNNew","HBT2","New","160","587","50","30")
;Gui, Add, Button, gSaveNNew, Save + New Question
;Gui, Add, Picture, x0 y593 gSkip, skip.png
ThirdButton("Skip","HBT3","Skip","10","587","50","30")
;Gui, Add, Button, gSkip, Skip
;Gui, Add, Picture, x0 y0 gExitNoSave, exitarrow.png
ThirdButton("ExitNoSave","HBT4","Back","10","10","50","30")
;Gui, Add, Button, gExitNoSave, Exit without Saving
Gui, Add, Edit,-E0x200 x15 y300 w340 h40 vQCon, 
Gui, Add, Edit,-E0x200 x15 y385 w340 h40 vACon,
Gui,Show, w376 h598
Gui, -Caption
Iterator()

return


CreateLinkedQuestions(inputWords) {
inputWords := StrSplit(inputWords, "|")
possibleHits := []
Loop, read, keyWords.dat
{
FileReadLine, currentLine, keyWords.dat, %A_Index%
compareWords := ""
compareWords := StrSplit(currentLine, "|")
for i, ele1 in inputWords {
for j, ele2 in compareWords {
if (ele1  = ele2) {
strength += 1
}
}
}
if (strength > 4) {
;msgBox %A_Index%_%strength%
possibleHits.Push(A_Index)
strength = 0
}
}

Str := ""
For Index, Value In possibleHits
   Str .= "," . Value
Str := LTrim(Str, ",") ; Remove leading pipes (|)
;msgbox %Str%
return Str
}


Iterator() {
    global lineNo
    global NewToLearn
	global importance
importance = 0
GuiControl, , ImpGU, Importance:

;Deletes any blank lines
 Loop,Read,toLearn.txt
    If (A_LoopReadLine!="")
      newText.=A_LoopReadLine "`r`n" C
  FileDelete,toLearn.txt
  FileAppend,%newText%,toLearn.txt



      if (lineNo = 0) {
      lineNo +=1
  } else {
FileRead, filecontent, toLearn.txt
	StringReplace, filecontent, filecontent, %NewToLearn%,,
    StringReplace, filecontent, filecontent,`r`n,,
	FileDelete, toLearn.txt
	FileAppend, %filecontent%, toLearn.txt
  }
     FileReadLine, NewToLearn, toLearn.txt, 1
     if (ErrorLevel = 1) {
GuiControl, , ToLearn, <<Manual Entry>>
  } else {
    GuiControl, , ToLearn, %NewToLearn%
  }
}

VImport:
importance=3
GuiControl, , Vimp, assets/vimportsel.png
GuiControl, , Imp, assets/importunse.png
GuiControl, , Limp, assets/limportunse.png
;GuiControl,, img, D:\image2.bmp
return

Import:
importance=2
GuiControl, , Imp, assets/importsel.png
GuiControl, , Vimp, assets/vimportunse.png
GuiControl, , Limp, assets/limportunse.png
return

LImport:
importance=1
GuiControl, , Limp, assets/limportsel.png
GuiControl, , Vimp, assets/vimportunse.png
GuiControl, , Imp, assets/importunse.png
return

SaveNExit:
if (importance = 0) {
msgbox Must add importance
} else {
GuiControlGet, QVar,, QCon
GuiControlGet, AVar,, ACon
FileAppend, %QVar% `n, toRemember.dat
FileAppend, %AVar% `n, toRemember.dat
FormatTime, Current,, yyyyMMddHHmmss
;msgbox, %QVar%
NextDate := NewDate()





FormatTime, NextDate, %NextDate%, yyyyMMdd
toSearch = %QVar% %AVar%
vText := GetKeyWords(toSearch)
linkedQuestions := CreateLinkedQuestions(vText)
FileAppend, %Current%_%NextDate%000000_2.5_1_1_1_%linkedQuestions%_%importance% `n, qStat.dat
;qStat.dat defaults= lastdate (today), nextdate (tomorrow), e-factor (2.5),iteration, interval (1), isActive (1), relatedQuestions
GuiControl, , QCon, % " " QCon
GuiControl, , ACon, % " " ACon
GuiControl, , Vimp, assets/vimportunse.png
GuiControl, , Imp, assets/importunse.png
GuiControl, , Limp, assets/limportunse.png
FileAppend, %vText%`n, keyWords.dat

Iterator()
}
return

Skip:
Iterator()
return

NewDate() {
    NextDate = %a_now%


;loop from this day looking for a day with less than 60 questions
            
            ;msgbox %NextDate% - %Current% = %FreshDate%
            ;calculate difference between dates
            ;use difference for the amount to loop backward
            saved = false
            loop , 60 {
                tempToteQuest = 0
                if (%saved%=false) {
                checkDate = %NextDate%
                checkDate += %A_Index%, Days
                checkDate := SubStr(checkDate, 1, 8)
                checkDate = %checkDate%000000
                ;msgbox %checkDate%
                ;*****************
                Loop , read, qStat.dat
                {
                    questionStats := StrSplit(A_LoopReadLine, "_")
                    toCompare := questionStats[2]
                    
                    if (toCompare = checkDate) {
                        tempToteQuest += 1       
                    }
                }
                if (tempToteQuest <= 60) {
                    ;save it
                    NextDate = %checkDate%
                    ;msgbox more than 60 I can save on previous day
                    saved = true
                }

                if (saved = true) {
                    Goto, leaveLoop2
                }
                ;*****************

                if (A_Index = 60) {
                    NextDate = %a_now%
                    ;msgbox no under 60s I cant save
                }
            }
            }
            leaveLoop2:
            return %NextDate%
            ;loop through questions using same totalquestions function
}



SaveNNew:
if (importance = 0) {
msgbox Must add importance
} else {
GuiControlGet, QVar,, QCon
GuiControlGet, AVar,, ACon
FileAppend, %QVar% `n, toRemember.dat
FileAppend, %AVar% `n, toRemember.dat
FormatTime, Current,, yyyyMMddHHmmss
NextDate := NewDate()





FormatTime, NextDate, %NextDate%, yyyyMMdd
toSearch = %QVar% %AVar%
vText := GetKeyWords(toSearch)
linkedQuestions := CreateLinkedQuestions(vText)
FileAppend, %Current%_%NextDate%000000_2.5_1_1_1_%linkedQuestions%_%importance% `n, qStat.dat
GuiControl, , QCon, % " " QCon
GuiControl, , ACon, % " " ACon
GuiControl, , Vimp, assets/vimportunse.png
GuiControl, , Imp, assets/importunse.png
GuiControl, , Limp, assets/limportunse.png

FileAppend, %vText%`n, keyWords.dat
importance = 0
GuiControl, , ImpGU, Importance:
}
return

GetKeyWords(vText)
{
redundant := ["however", "they", "there", "then", "those", "also", "therefore", "asking","allow","want", "seperate", "Is", "more", "being", "given", "step", "'", "...", "?", "one", "two", "three", "four", "first", "second", "third", "fourth", "recurring", "issue", "aware", "therefore", "Every", "into", "never", "them", "anything", "anyone", "walk", "path", "short", "Best", "used", "make", "keep", "Occasionally", "with", "long", "Should","useful","comes","They","using","their","Define", "drives", "example", "much","okay","most","does","Where","A","drop","Okay", "Only", "will", "having", "remind","yourself","Their","Do","great","good","bad","What","It","every","is","In","When","this","become","Becoming","what","must","should","upon", "your","makes","open","things","thing","have","s","I", "am", "yes", "no", "maybe", "...", "it's", "not", "about", "and", "but", "for", "nor", "or", "so", "yet", "a", "an", "the", "because", "after", "although", "as", "before", "even", "if", "inasmuch", "lest", "now", "once", "provided", "since", "supposing", "than", "that", "though", "till", "unless", "until", "when", "whenever", "where", "whereas", "wherever", "whether", "which", "while", "who", "whoever", "why"]
for i, element in redundant {
    StringLower, element, element
    StringLower, vText, vText
 ;vText:= StrReplace(vText, element, "", Count)
search = \b%element%\b
;msgbox %search%
 vText:= RegExReplace(vText,search," ")
}
keywords := StrSplit(vText, " ")
export := []
for i, element in keywords {
if (element != "") && (element != " ") && (element != "\b") {
export.Push(element)
}
}
Str := ""
For Index, Value In export
   Str .= "|" . Value
Str := LTrim(Str, "|") ; Remove leading pipes (|)
return Str
}

ExitNoSave:
ExitApp
return

GuiClose:
ExitApp