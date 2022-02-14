#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
#Include, libraries/Class_ImageButton.ahk
#Include libraries/UseGDIP.ahk
#Include libraries/styleGuide.ahk

xpos := A_ScreenWidth/2-362
ypos := A_ScreenHeight/2-335



FileReadLine, VNum, %A_WorkingDir%\Readme.md, 3 ;looks for local version text and stores as vnum
	if ErrorLevel = 1
	Vnum = 0
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/trojanface/Minerva/master/Readme.md", true)
whr.Send()
; Using 'true' above and the call below allows the script to remain responsive.
whr.WaitForResponse() ;this is taken from the installer. Can also be located as an example on the urldownloadtofile page of the quick reference guide.
version := whr.ResponseText
Loop, parse, version, `n,
{
	if (A_Index = 3) {
		version = %A_LoopField%
	}
}
if (version != VNum) {
MsgBox, Your current version is %Vnum%. The latest is %version%. Minerva will now exit and update.
	IfMsgBox OK
	Loop, read, toUpdate.dat 
{
FileReadLine, currentLine, toUpdate.dat, %A_Index%
FileUpdater("https://raw.githubusercontent.com/trojanface/Minerva/master/"currentLine,currentLine)
}
		if (ErrorLevel = 1) {
			MsgBox, There was some error updating the file. You may have the latest version, or it is blocked.
		} else if (ErrorLevel = 0) {
			MsgBox, The update appears to have been successful or you clicked cancel. Please restart Minerva
			ExitApp
		} else {
			MsgBox, some other crazy error occured. 
		}
}

;QTarg = 30
FirstTime()
Gui, New, , Minerva
Gui, Add, Picture, x0 y0 , assets/MainMenu2.png
SecondaryButton("Minimise","HBT7","-","8","8","25","25")
SecondaryButton("GuiClose","HBT8","X","139","8","25","25")
;Gui, Add, Picture, x5 y1  gMinimise , minimise.png
;Gui, Add, Picture, x148 y1  gGuiClose , close.png
Gui, Add, Text, +BackgroundTrans x34 y153 vQCon w120, Q: %totalQuestion%
Gui, Add, Text, +BackgroundTrans x34 y168 vACon w120, R: %answerScore%
;Gui, Add, Picture, x30 y175  gRefresh , refresh.png
PrimaryButton("Refresh","HBT1","Refresh","30","205","114","25")
PrimaryButton("QuizBuilder","HBT2","Quiz Builder","30","259","114","25")
;Gui, Add, Picture, x30 y259  gQuizBuilder , quizbuild.png
FileGetSize, fileSize, qStat.dat
	if (fileSize > 0) {
		PrimaryButton("Quiz","HBT4","Quiz","30","289","114","25")
;Gui, Add, Picture, x30 y289  gQuiz , quizbut.png
	}
	PrimaryButton("ToLearn","HBT5","To Learn","30","319","114","25")
;Gui, Add, Picture, x30 y319  gToLearn , tolearn.png
PrimaryButton("Quit","HBT6","Quit","30","349","114","25")
;Gui, Add, Picture, x30 y349  gQuit , exit.png
Gui, Show,  x%xpos% y%ypos% w166 h368
Gui, -Caption
RefreshFunc()
return

FileUpdater(path,filename) {
	whr2 := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		whr2.Open("GET", path, true)
whr2.Send()
; Using 'true' above and the call below allows the script to remain responsive.
whr2.WaitForResponse() ;this is taken from the installer. Can also be located as an example on the urldownloadtofile page of the quick reference guide.
newFile := whr2.ResponseText
FileDelete, %A_WorkingDir%\%filename%
FileAppend, %newFile%, %A_WorkingDir%\%filename%
;Have had to include the below check as there appears to be some type of bug when AHK Appends above. It is adding a ? to the start of the files. The below removes it.
FileReadLine, BugCheck, %A_WorkingDir%\%filename%, 1
if (SubStr(BugCheck, 1, 1) = "?") {
	FileRead, FileContents, %A_WorkingDir%\%filename%
	StringTrimLeft, NewFileContents, FileContents, 1
	FileDelete, %A_WorkingDir%\%filename%
FileAppend, %NewFileContents%, %A_WorkingDir%\%filename%
}
return
}


Refresh:
RefreshFunc()
return

FirstTime() {
	if FileExist("firstRun.dat") {
		Backup()
	} else {
			FormatTime, Current,, yyyyMMdd
FileAppend, , averages.dat
FileAppend, , elaborations.dat
FileAppend, , keyWords.dat
FileAppend, , qStat.dat
FileAppend, , settings.dat
FileAppend, , toLearn.txt
;FileAppend, , toRemember.dat
FileCreateDir, backup
FileAppend, %Current%, firstRun.dat
}
}

BackupFunc(fileName) {
	FormatTime, Current,, yyyyMMdd
	FileRead, firstcontent, firstRun.dat
	if (Current != firstcontent) {
if FileExist(fileName) {
	FileGetSize, fileSize, %fileName%
	if (fileSize <= 0) {
		FreshDate := Current-1
conCat = %FreshDate%%fileName%
		if FileExist("backup\"conCat) {
	
	FileGetSize, fileSize2, backup\%conCat%
	if (fileSize2 > 0) {
					
		;restore from backup
FileDelete, %fileName%

		FileRead, filecontent, backup\%conCat%
		FileAppend, %filecontent%, %fileName%
		FileAppend, %filecontent%, backup/%Current%%fileName%
		msgbox An error has occurred. Minerva has restored %fileName% from a backup.
	}
		}
	} else {
		;Make a backup of it
		conCatCur = %Current%%fileName%
		if FileExist("backup\"conCatCur) {
	if (fileSize > 0) {
FileDelete, backup\%conCatCur%
	}
}
		FileRead, filecontent, %fileName%
		FileAppend, %filecontent%, backup/%Current%%fileName%
	}
}
;Cleanup backups older than one day
Loop, 10 {
FreshDate := Current-A_Index
conCat = %FreshDate%%fileName%
if FileExist("backup\"conCat) {
	if (fileSize > 0) {
FileDelete, backup\%conCat%
	}
}
}
}
}


RefreshFunc() {
Loop, read, qStat.dat 
{
FileReadLine, currentLine, qStat.dat, %A_Index%
questionStats := StrSplit(currentLine, "_")
toCompare := questionStats[2]
FormatTime, Current,, yyyyMMddHHmmss
if (toCompare <= Current) && (questionStats[6] = 1) {
totalQuestion += 1
}
}

FileReadLine, settingOne, settings.dat, 1
if (settingOne != "") {
settingStats := StrSplit(settingOne, "_")
FormatTime, Current,,yyyyMMdd
answerScore = 0
if (settingStats[1] != Current) {
newSetOne = %Current%_%totalQuestion%_0

FileRead, filecontent, settings.dat
	StringReplace, filecontent, filecontent, %settingOne%,%newSetOne%
	FileDelete, settings.dat
	FileAppend, %filecontent%, settings.dat
sleep 200
} else {
answerScore = % settingStats[3]
totalQuestion = % settingStats[2]
}

} else {
FormatTime, Current,,yyyyMMdd
newSetOne = %Current%_%totalQuestion%_0
	FileAppend, %newSetOne%, settings.dat
}
if (answerScore >= 0) {

answerScore := (answerScore/totalQuestion)*100
numPercent := floor(answerScore)
if (answerScore > 85) {
answerScore = A - %numPercent%`%
}
if (answerScore >= 75) && (answerScore < 85) {
answerScore = B - %numPercent%`%
}
if (answerScore >= 65) && (answerScore < 75) {
answerScore = C - %numPercent%`%
}
if (answerScore > 50) && (answerScore < 65) {
answerScore = D - %numPercent%`%
}
if (answerScore <= 50) {
answerScore = F - %numPercent%`%
}
} else {
answerScore = n/a
}
GuiControl, , QCon, Q: %totalQuestion%
GuiControl, , ACon, R: %answerScore%
}

QuizBuilder:
Run, "QuizBuilder.ahk"
return

ToLearn:
Run, "toLearn.txt"
sleep 1000
MsgBox, , Hint, Place information you want to remember in this document. NOTE: One line per fact., 5
return

Quiz:
Run, "Quiz.ahk"
return

Quit:
Backup()
ExitApp
return

Minimise:
WinMinimize 
return

GuiClose:
Backup()
ExitApp

Backup() {
BackupFunc("averages.dat")
BackupFunc("elaborations.dat")
BackupFunc("emotions.dat")
BackupFunc("keyWords.dat")
BackupFunc("qStat.dat")
BackupFunc("settings.dat")
BackupFunc("toLearn.txt")
;BackupFunc("toRemember.dat")
	return
}