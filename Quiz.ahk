#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.
#Persistent
#Include, libraries/Class_ImageButton.ahk
#Include libraries/UseGDIP.ahk
#Include libraries/styleGuide.ahk
#Include libraries/hapticfeedback.ahk
questionNo = 0
tenQuestions = 0
tenQuestionsScore = 0
toteQuest = 0
answerVar =
    questionVar =
    currentQNO = 1
  
Gui , mainQM: New, , Minerva - Quiz
Gui , mainQM: Add, Picture, x0 y0, assets/quiz.png
;Gui , Add, Picture, x0 y0 gExitNoSave, exitarrow.png
ThirdButton("ExitNoSave","HBT10","Back","10","10","50","30")
  Gui, Font, s10
Gui , mainQM: Add, Text, +BackgroundTrans x360 y15 vQCount w380,
    Gui , mainQM: Add, Text, +BackgroundTrans x8 y96 vQCon w380 h200,
;Gui , mainQM: Add, Picture, x103 y164 gShowAnswer, show.png
FourthButton("ShowAnswer","HBT1","Show Answer","103","234","200","32")
;Gui, mainQM:Add, Button, Default gShowAnswer, Show Answer
Gui , mainQM: Add, Text, +BackgroundTrans x8 y300 vACon w380 h200, 
;Gui , mainQM: Add, Picture, x13 y315 gPerfect, perfect.png
TenthButton("Perfect","HBT2","Perfect","10","470","382","32")
;Gui, mainQM:Add, Button, Default gPerfect, Perfect Response
;Gui , mainQM: Add, Picture, x13 y353 gCorrect1, correcthesi.png
FifthButton("Correct1","HBT3","Correct Response after hesitation","10","510","382","32")
;Gui, mainQM:Add, Button, Default gCorrect1, Correct Response after hesitation
;Gui , mainQM: Add, Picture, x13 y391 gCorrect2, correctdiff.png
SixthButton("Correct2","HBT4","Correct Response with serious difficulty","10","550","382","32")
;Gui, mainQM:Add, Button, Default gCorrect2, Correct Response with serious difficulty
;Gui , mainQM: Add, Picture, x13 y429 gIncorrect1, incorrecteasy.png
SeventhButton("Incorrect1","HBT5","Incorrect Response where Correct response easy to recall","10","590","382","32")
;Gui, mainQM:Add, Button, Default gIncorrect1, Incorrect Response where Correct response easy to recall
;Gui , mainQM: Add, Picture, x13 y467 gIncorrect2, incorrecteven.png
EigthButton("Incorrect2","HBT6","Incorrect Response where correct response recalled eventually","10","630","382","32")
;Gui, mainQM:Add, Button, Default gIncorrect2, Incorrect Response where correct response recalled eventually
;Gui , mainQM: Add, Picture, x13 y505 gBlackout, blackout.png
NinthButton("Blackout","HBT7","Complete blackout","10","670","382","32")
;Gui, mainQM:Add, Button, Default gBlackout, Complete blackout
;Gui , mainQM: Add, Picture, x0 y557 gEdit, edit.png
ThirdButton("Edit","HBT8","Edit","10","748","50","32")
;Gui, mainQM:Add, Button, Default gEdit, Edit
;Gui , mainQM: Add, Picture, x352 y559 gDelete, delete.png
ThirdButton("Delete","HBT9","Delete","342","748","50","30")
;Gui, mainQM:Add, Button, Default gDelete, Delete
;Gui , mainQM: Add, Picture, x173 y540 gQuizBuilder, add.png
;CustomButton("QuizBuilder","HBT10","Add Question","173","540","61","45")
;Gui, mainQM:Add, Button,  gQuizBuilder, Create New Question
Gui , mainQM: Show, w396 h760, Minerva
Gui , -Caption
questionPriority = 3
GetTotal()

Iterator()
return



ExitNoSave:
    ExitApp
    return

    GetTotal() {
        global totalQuestion
        global questionNo
        global currentQNO
        Loop , read, qStat.dat
        {
            FileReadLine , currentLine, qStat.dat, %A_Index%
            questionStats := StrSplit(currentLine, "_")
            toCompare := questionStats[2]
            FormatTime , Current, , yyyyMMddHHmmss
            if (toCompare <= Current) && (questionStats[6] = 1) && (questionStats[8] != 0) {
                totalQuestion += 1
            }
        }
        GuiControl , mainQM: , qCount, %currentQNO% / %totalQuestion%
        return
    }

    GetKeyWords(vText)
    {
        redundant := ["seperate", "Is", "more", "being", "given", "step", "recurring", "issue", "aware", "therefore", "Every", "into", "never", "them", "anything", "anyone", "walk", "path", "short", "Best", "used", "make", "keep", "Occasionally", "with", "long", "Should", "useful", "comes", "They", "using", "their", "Define", "drives", "example", "much", "okay", "most", "does", "Where", "A", "drop", "Okay", "Only", "will", "having", "remind", "yourself", "Their", "Do", "great", "good", "bad", "What", "It", "every", "is", "In", "When", "this", "become", "Becoming", "what", "must", "should", "upon", "your", "makes", "open", "things", "thing", "have", "s", "I", "am", "yes", "no", "maybe", "...", "it's", "not", "about", "and", "but", "for", "nor", "or", "so", "yet", "a", "an", "the", "because", "after", "although", "as", "before", "even", "if", "inasmuch", "lest", "now", "once", "provided", "since", "supposing", "than", "that", "though", "till", "unless", "until", "when", "whenever", "where", "whereas", "wherever", "whether", "which", "while", "who", "whoever", "why"]
        for i, element in redundant {
            ;vText:= StrReplace(vText, element, "", Count)
            search = \b%element%\b
            ;msgbox %search%
            vText := RegExReplace(vText, search, " ")
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
        Str := LTrim(Str, "|")	; Remove leading pipes (|)
        return Str
    }

QuizBuilder:
    Run , "QuizBuilder.ahk"
    return

Edit:
    InputBox , newQuestion, Question, Edit the Question, , , , , , , , %questionVar%
    InputBox , newAnswer, Answer, Edit the Answer, , , , , , , , %answerVar%
    InputBox , newPriority, Importance, Enter Importance: 1 (Less important) - 2 (Important) - 3 (Very Important), , , , , , , ,
    FileReadLine , questionStat, qStat.dat, %questionNo%
    sleep 200
    questionStats := StrSplit(questionStat, "_")
    firstDate := questionStats[1]
    secondDate := questionStats[2]
    easeFactor := questionStats[3]
    iteration := questionStats[4]
    interval := questionStats[5]
    relations := questionStats[7]
    importance := questionStats[8]
    questionsav := newQuestion
    answersav := newAnswer
    newStats = %firstDate%_%secondDate%_%easeFactor%_%iteration%_%interval%_1_%relations%_%newPriority%_%questionsav%_%answersav%
    FileRead , filecontent, qStat.dat
    StringReplace , filecontent, filecontent, %questionStat%, %newStats%
    FileDelete , qStat.dat
    FileAppend , %filecontent%, qStat.dat
    sleep 200
    GuiControl , mainQM: , QCon, % "`n " newQuestion 
    GuiControl , mainQM: , ACon, % "`n " newAnswer
    return

Delete:
    ;msgbox %questionNo%
    FileReadLine , questionStat, qStat.dat, %questionNo%
    sleep 200
    questionStats := StrSplit(questionStat, "_")
    firstDate := questionStats[1]
    secondDate := questionStats[2]
    easeFactor := questionStats[3]
    iteration := questionStats[4]
    interval := questionStats[5]
    relations := questionStats[7]
    importance := questionStats[8]
      questionsav := questionStats[9]
    answersav := questionStats[10]
    newStats = %firstDate%_%secondDate%_%easeFactor%_%iteration%_%interval%_0_%relations%_%importance%_%questionsav%_%answersav%
    FileRead , filecontent, qStat.dat
    StringReplace , filecontent, filecontent, %questionStat%, %newStats%
    FileDelete , qStat.dat
    FileAppend , %filecontent%, qStat.dat
    sleep 200
    return

ShowAnswer:
    GuiControl , mainQM: , ACon, % "`n " answerVar
    return

Perfect:
    UpdateStat(5)
    HapticFunc("Perfection.png","WellDone.png","GreatJob.png")
    return
Correct1:
    UpdateStat(4)
    HapticFunc("WellDone.png","GreatJob.png","NiceOne.png")
    return
Correct2:
    UpdateStat(3)
    HapticFunc("PrettyGood.png","NotBad.png")
    return
Incorrect1:
    FileReadLine , questVar, qStat.dat, questionNo
    questionStats := StrSplit(questVar, "_")
    ;msgbox % questionStats[4]
    if (questionStats[4] > 7) && (questionStats[3] < 2) {
        WrongMenu(2)
    } else {
        UpdateStat(2)
    }
    HapticFunc("PrettyGood.png","NotBad.png")
    return
Incorrect2:
    FileReadLine , questVar, qStat.dat, questionNo
    questionStats := StrSplit(questVar, "_")
    ;msgbox % questionStats[4]
    if (questionStats[4] > 7) && (questionStats[3] < 2) {
        WrongMenu(1)
    } else {
        UpdateStat(1)
    }
    HapticFunc("GoodTry.png","DontGiveUp.png")
    return

Blackout:
    FileReadLine , questVar, qStat.dat, questionNo
    questionStats := StrSplit(questVar, "_")
    ;msgbox % questionStats[4]
    if (questionStats[4] > 7) && (questionStats[3] < 2) {
        WrongMenu(0)
    } else {
        UpdateStat(0)
    }
    HapticFunc("NextTime.png","DontGiveUp.png")
    return

Connect:
    ConnectQuestion()
    Gui , wrongM: Hide
    return

Joy:
    Emotion(20)
    return

Passion:
    Emotion(19)
    return

Enthusiasm:
    Emotion(19)
    return

Positive:
    Emotion(18)
    return

Optimism:
    Emotion(17)
    return

Hope:
    Emotion(16)
    return

Content:
    Emotion(15)
    return

Bored:
    Emotion(14)
    return

Frustrated:
    Emotion(13)
    return

Overwhelmed:
    Emotion(12)
    return

Disappointed:
    Emotion(11)
    return

Doubt:
    Emotion(10)
    return

Worry:
    Emotion(9)
    return

Discourage:
    Emotion(8)
    return

Anger:
    Emotion(7)
    return

Vengeful:
    Emotion(6)
    return

Hate:
    Emotion(5)
    return

Jealous:
    Emotion(4)
    return

Insecure:
    Emotion(3)
    return

Afraid:
    Emotion(2)
    return

    ShowElaboration() {
        global newQuality
        global elaborationVar
        msgbox %elaborationVar%
        UpdateStat(%newQuality%)
        return
    }

    CreateElaboration() {
        global newQuality
        global questionNo
    FileReadLine , questionStat, qStat.dat, %questionNo%
   questionStats := StrSplit(questionStat, "_")
    conQuestVar := questionStats[9]
    conAnsVar := questionStats[10]

               InputBox , newAnswer, Elaboration, Elaborate upon the following: %conQuestVar% - %conAnsVar%, , , , , , , ,
            if (newAnswer != "") {
                FileAppend , %questionNo%_%newAnswer% `n, elaborations.dat
                Gui , wrongM: Hide
            }
        UpdateStat(%newQuality%)
        return
    }

    Rote() {
        global newQuality
        global questionNo
    FileReadLine , questionStat, qStat.dat, %questionNo%
   questionStats := StrSplit(questionStat, "_")
    conQuestVar := questionStats[9]
    conAnsVar := questionStats[10]

        InputBox , newQuestion, Rote Question, Type out the following: %conQuestVar% - %conAnsVar% , , , , , , , ,
            ;InputBox, newAnswer , Rote Answer, Type out the following: %conAnsVar%, , , , , , , ,
            Gui , wrongM: Hide
        UpdateStat(%newQuality%)
        return
    }

    Relational() {
        global newQuality
        global questionNo
    FileReadLine , questionStat, qStat.dat, %questionNo%
   questionStats := StrSplit(questionStat, "_")
    conQuestVar := questionStats[9]
    conAnsVar := questionStats[10]

        InputBox , newQuestion, Relational Question, Create a new question that is the opposite of '%conQuestVar% - %conAnsVar%'.New Question: , , , , , , , ,
            InputBox , newAnswer, Relational Answer, Create a new question that is the opposite of '%conQuestVar% - %conAnsVar%'.New Answer: , , , , , , , ,
            if (newQuestion != "") && (newAnswer != "") {

                FileReadLine , questionStat, qStat.dat, %questionNo%
                sleep 200
                questionStats := StrSplit(questionStat, "_")
                firstDate := questionStats[1]
                secondDate := questionStats[2]
                easeFactor := questionStats[3]
                iteration := questionStats[4]
                interval := questionStats[5]
                importance := questionStats[8]
                questionSav := questionStats[9]
                answerSav := questionStats[10]
                relations := LTrim(questionStats[7], linkStats[1])
                relations := LTrim(relations, ",")
                newStats = %firstDate%_%secondDate%_%easeFactor%_%iteration%_%interval%_1_%relations%_%importance%_%questionSav%_%answerSav%
                FileRead , filecontent, qStat.dat
                StringReplace , filecontent, filecontent, %questionStat%, %newStats%
                FileDelete , qStat.dat
                FileAppend , %filecontent%, qStat.dat
                FormatTime , Current, , yyyyMMddHHmmss
                NextDate = %a_now%
                NextDate += +60, Days


;loopbackward from this day looking for a day with less than 60 questions
            FreshDate := NextDate
            FreshDate -= Current, Days

            ;msgbox %NextDate% - %Current% = %FreshDate%
            ;calculate difference between dates
            ;use difference for the amount to loop backward
            saved = false
            loop , %FreshDate% {
                if (%saved%=false) {
                checkDate = %NextDate%
                checkDate += -%A_Index%, Days
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
                    ;msgbox less than 60 I can save
                    saved = true
                }

                if (saved = true) {
                    Goto, leaveLoop3
                }
                ;*****************

                if (A_Index = FreshDate) {
                    NextDate = %a_now%
                    ;msgbox no under 60s I cant save
                    NextDate += +interval, Days
                }
            }
            }
            leaveLoop3:
            ;loop through questions using same totalquestions function



                FormatTime , NextDate, %NextDate%, yyyyMMdd
                toSearch = %newQuestion% %newAnswer%
                vText := GetKeyWords(toSearch)
                linkedQuestions := CreateLinkedQuestions(vText)
                FileAppend , %Current%_%NextDate%000000_2.5_1_1_1_%linkedQuestions%_1_%newQuestion%_%newAnswer% `n, qStat.dat
                FileAppend , %vText%`n, keyWords.dat
            }
        Gui , wrongM: Hide
        UpdateStat(%newQuality%)
        return
    }

    GoogleQuestion() {
        global newQuality
        global questionNo
            FileReadLine , questionStat, qStat.dat, %questionNo%
   questionStats := StrSplit(questionStat, "_")
    queryQuestVar := questionStats[9]
        parameter = C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe https://www.google.com/search?q="%queryQuestVar%"
        ;msgbox %parameter%
        Run %parameter%
        InputBox , newQuestion, Linked Question, Create a new question that will support the previous question with facts discovered in your browsing session.New Question: , , , , , , , ,
            InputBox , newAnswer, Linked Answer, Create a new question that will support the previous question with facts discovered in your browsing session.New Answer: , , , , , , , ,
            Gui , wrongM: Hide
        UpdateStat(%newQuality%)
        return
    }

    ConnectQuestion() {
        global newQuality
        global questionNo
        FileReadLine , questVar, qStat.dat, %questionNo%
        questionStats := StrSplit(questVar, "_")

        ;msgbox % questionStats[7]
        linkStats := StrSplit(questionStats[7], ",")

    conQuestVar := questionStats[9]
     conAnsVar := questionStats[10]   

        if (linkStats[1] != "") {
            InputBox , newQuestion, Linked Question, Create a new question relevant to the previous question / answer and this one... %conQuestVar% : %conAnsVar% New Question: , , , , , , , ,
                InputBox , newAnswer, Linked Answer, %conQuestVar% : %conAnsVar% New Answer: , , , , , , , ,
        } else {
            msgbox No linked questions available.
        }
        if (newQuestion != "") && (newAnswer != "") {

            FileReadLine , questionStat, qStat.dat, %questionNo%
            sleep 200
            questionStats := StrSplit(questionStat, "_")
            firstDate := questionStats[1]
            secondDate := questionStats[2]
            easeFactor := questionStats[3]
            iteration := questionStats[4]
            interval := questionStats[5]
            importance := questionStats[8]
            questionSav := questionStats[9]
            answerSav := questionStats[10]
            relations := LTrim(questionStats[7], linkStats[1])
            relations := LTrim(relations, ",")
            newStats = %firstDate%_%secondDate%_%easeFactor%_%iteration%_%interval%_1_%relations%_%importance%_%questionSav%_%answerSav%
            FileRead , filecontent, qStat.dat
            StringReplace , filecontent, filecontent, %questionStat%, %newStats%
            FileDelete , qStat.dat
            FileAppend , %filecontent%, qStat.dat
            FormatTime , Current, , yyyyMMddHHmmss
            NextDate = %a_now%
            NextDate += +60, Days


;loopbackward from this day looking for a day with less than 60 questions
            FreshDate := NextDate
            FreshDate -= Current, Days

            ;msgbox %NextDate% - %Current% = %FreshDate%
            ;calculate difference between dates
            ;use difference for the amount to loop backward
            saved = false
            loop , %FreshDate% {
                if (%saved%=false) {
                checkDate = %NextDate%
                checkDate += -%A_Index%, Days
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
                    ;msgbox less than 60 I can save
                    saved = true
                }

                if (saved = true) {
                    Goto, leaveLoop2
                }
                ;*****************

                if (A_Index = FreshDate) {
                    NextDate = %a_now%
                    ;msgbox no under 60s I cant save
                    NextDate += +interval, Days
                }
            }
            }
            leaveLoop2:
            ;loop through questions using same totalquestions function


            FormatTime , NextDate, %NextDate%, yyyyMMdd
            toSearch = %newQuestion% %newAnswer%
            vText := GetKeyWords(toSearch)
            linkedQuestions := CreateLinkedQuestions(vText)
            FileAppend , %Current%_%NextDate%000000_2.5_1_1_1_%linkedQuestions%_1_%newQuestion%_%newAnswer% `n, qStat.dat
            FileAppend , %vText%`n, keyWords.dat
        }

        UpdateStat(%newQuality%)
        return
    }

    CreateLinkedQuestions(inputWords) {
        inputWords := StrSplit(inputWords, "|")
        possibleHits := []
        Loop , read, keyWords.dat
        {
            FileReadLine , currentLine, keyWords.dat, %A_Index%
            compareWords := ""
            compareWords := StrSplit(currentLine, "|")
            for i, ele1 in inputWords {
                for j, ele2 in compareWords {
                    if (ele1 = ele2) {
                        strength += 1
                    }
                }
            }
            if (strength > 2) {
                ;msgBox %A_Index%_%strength%
                possibleHits.Push(A_Index)
                strength = 0
            }
        }

        Str := ""
        For Index, Value In possibleHits
            Str .= "," . Value
        Str := LTrim(Str, ",")	; Remove leading pipes (|)
        ;msgbox %Str%
        return Str
    }

    Iterator() {
        global questionNo
        global answerVar
        global questionVar
        global questionPriority
        global totalQuestion
        global currentQNO
        global tenQuestions
        global toteQuest
        GuiControl , mainQM: , qCount, %currentQNO% / %totalQuestion%
        FormatTime , Current, , yyyyMMddHHmmss
        ;msgbox %questionNo%
        Loop , read, qStat.dat
        {
            questionStats := StrSplit(A_LoopReadLine, "_")
            toCompare := questionStats[2]
            if (toCompare <= Current) && (questionStats[6] = 1) && (questionStats[8] = questionPriority) {
                ;MsgBox, %toCompare% compared to %Current%
                questionVar := questionStats[9]
                answerVar := questionStats[10]
                GuiControl , mainQM: , QCon, % "`n " questionVar ;" (DEBUG): #" questionNo  " priority: " questionPriority
                GuiControl , mainQM: , ACon, % "`n "
                currentQNO += 1
                questionNo += 1
                toteQuest += 1
                tenQuestions += 1
                if (tenQuestions >= 10) {
                   ; EmotionMenu()
                    tenQuestions = 0
                }
                break

            } else {
                FileReadLine , questionVar, qStat.dat, % A_Index + 1
                if (ErrorLevel = 1) {
                    ;msgbox % A_Index * 2 + 1
                    if (questionPriority = 0) {
                        msgbox , There are no more questions to answer today. Check back tomorrow.
                        ExitApp
                    } else {
                        ;will need to make this function work in the calc of totalquestions function also, probably a better place to start.
                        ;1. check to see if total questions > 60 or scrounger >= 3
                        ;2a. if not ->
                        ;3a. borrow questions from next three days, scrounger loops up to 3 each time pushing acceptable date += 1 and not iterating questionpriority before starting from beginning
                        ;2b. if so ->
                        questionPriority -= 1
                        ;reset scrounger to 0
                        questionNo = 0
                        ;msgbox %questionPriority%
                        Iterator()
                    }
                } else {
                    questionNo = %A_Index%
                }
            }
        }

        return
    }

    Emotion(rating) {
        global toteQuest
        global tenQuestionsScore
        ;msgbox %rating% %toteQuest% %tenQuestionsScore%
        ;needs to save the total questions answered, how many in the last 10 were correct, emotion rating
        filecontent = %rating%_%tenQuestionsScore%_%toteQuest% `n
        FileAppend , %filecontent%, emotions.dat
        tenQuestionsScore = 0
        Gui , emotM: Hide
        return
    }

    EmotionMenu() {
        Gui , emotM: New, , Emotion Menu
        Gui , emotM: Add, Text, , Rate your emotional state
        Gui , emotM: Add, Button, gJoy, Joyful
        Gui , emotM: Add, Button, gPassion, Passionate
        Gui , emotM: Add, Button, gEnthusiasm, Enthusiastic
        Gui , emotM: Add, Button, gPositive, Positive
        Gui , emotM: Add, Button, gOptimism, Optimistic
        Gui , emotM: Add, Button, gHope, Hopeful
        Gui , emotM: Add, Button, gContent, Content
        Gui , emotM: Add, Button, gBored, Bored
        Gui , emotM: Add, Button, gFrustrated, Frustrated
        Gui , emotM: Add, Button, gOverwhelmed, Overwhelmed
        Gui , emotM: Add, Button, gDisappointed, Disappointed
        Gui , emotM: Add, Button, gDoubt, Doubtful
        Gui , emotM: Add, Button, gWorry, Worried
        Gui , emotM: Add, Button, gDiscourage, Discouraged
        Gui , emotM: Add, Button, gAnger, Angry
        Gui , emotM: Add, Button, gVengeful, Vengeful
        Gui , emotM: Add, Button, gHate, Hateful
        Gui , emotM: Add, Button, gJealous, Jealous
        Gui , emotM: Add, Button, gInsecure, Insecure
        Gui , emotM: Add, Button, gAfraid, Afraid
        Gui , emotM: Show, , Wrong Menu
        return
    }

    WrongMenu(quality) {
        global questionNo
        global elaborationVar
        global newQuality
        newQuality = %quality%
        Loop , read, elaborations.dat
        {
            questionStats := StrSplit(A_LoopReadLine, "_")
            toCompare := questionStats[1]
            if (toCompare = questionNo) {
                elaborationVar := questionStats[2]
            }
        }

        Gui , wrongM: New, , Wrong Menu
         ;These have been deactivated due to lack of need
        ;Gui , wrongM: Add, Button, gGoogleQuestion, Google Question
        ;Gui , wrongM: Add, Button, gConnect, New Linking Question
        Gui , wrongM: Add, Button, gRelational, New Relational Question
        Gui , wrongM: Add, Button, gRote, Rote Learn
      ;  if (elaborationVar = "") {
      ;      Gui , wrongM: Add, Button, gCreateElaboration, Create Elaboration
      ;  } else {
      ;      Gui , wrongM: Add, Button, gShowElaboration, Show Elaboration
      ;  }
        Gui , wrongM: Show, , Wrong Menu
        return
    }
    
NewDate(interval) {
        NextDate = %a_now%
  NextDate += %interval%, Days
            saved = false
            loop , %interval% {
                 tempToteQuest = 0
                if (%saved%=false) {
                checkDate = %NextDate%
                checkDate += -%A_Index%, Days
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
                FormatTime , CurrDate, , yyyyMMdd
                CurrDate = %CurrDate%000000
                if (tempToteQuest <= 60) && (checkDate != CurrDate) {
                    ;save it
                    NextDate = %checkDate%
                   ; msgbox less than 60 I can save %checkDate%
                    saved = true
                }

                if (saved = true) {
                    Goto, leaveLoop
                }
                ;*****************

                if (A_Index = interval) {
                    NextDate = %a_now%
                    ;msgbox no under 60s I cant save
                    NextDate += +interval, Days
                }
            }
            }
            leaveLoop:

            ;bug catcher
FormatTime , BugCatch, , yyyyMMdd
            FormatTime , NextDate, %NextDate%, yyyyMMdd
            if (NextDate = BugCatch) {
                msgbox bug caught! %interval%
            }


            return %NextDate%
}


    UpdateStat(quality) {
        global questionNo
        global totalQuestion
        global tenQuestionsScore
        global questionVar
        global answerVar
        ;msgbox %quality%
        FileReadLine , settingOne, settings.dat, 1
        FileReadLine , questionStat, qStat.dat, %questionNo%
        sleep 200
        questionStats := StrSplit(questionStat, "_")

        if (settingOne != "") {

            settingStats := StrSplit(settingOne, "_")

            FormatTime , Current, , yyyyMMdd

            if (settingStats[8] != 0) {
                if (settingStats[1] != Current) {
                    newSetOne = %Current%_%totalQuestion%_0

                    FileRead , filecontent, settings.dat
                    StringReplace , filecontent, filecontent, %settingOne%, %newSetOne%
                    FileDelete , settings.dat
                    FileAppend , %filecontent%, settings.dat
                } else {
                    if (quality > 2) {
                        tenQuestionsScore += 1
                        newQuestRight := settingStats[3] + 1
                        temp := settingStats[2]
                        newSetOne = %Current%_%temp%_%newQuestRight%
                        if (questionStats[8] > 0) {
                            FileRead , filecontent, settings.dat
                            StringReplace , filecontent, filecontent, %settingOne%, %newSetOne%
                            FileDelete , settings.dat
                            FileAppend , %filecontent%, settings.dat
                        }
                    }
                }
            }
        } else {
            FormatTime , Current, , yyyyMMdd
            newSetOne = %Current%_%totalQuestion%_0
            FileAppend , %newSetOne%, settings.dat
        }

        if (questionStats[8] > 0) {
               easeFactor := questionStats[3] + (0.1 - 5 * (5 - quality) * (0.08 + (5 - quality) * 0.02))
            if (easeFactor < 1.3) {
                easeFactor = 1.3
            }
            if (questionStats[4] = 1) {
                interval = 1
            }
            if (questionStats[4] = 2) {
                interval = 6
            }
            if (questionStats[4] > 2) {
                
                interval := (questionStats[4] - 1) * easeFactor

                 FileReadLine , averageVar, averages.dat, lineNum
            if (ErrorLevel) {
                ;msgbox no averages
            } else {

                ;calculate modifier here 
                 lineNum2 := questionStats[4]
                lineNum3 := questionStats[4] -1
                FileReadLine , averageVar, averages.dat, lineNum3
            FileReadLine , averageVar1, averages.dat, lineNum3
            FileReadLine , averageVar2, averages.dat, lineNum2
            nextIt := StrSplit(averageVar2, "_")
            currIt := StrSplit(averageVar1, "_")
                totalQuestionsAverage := averageItem[4]+1
                crit := ((currIt[2]-nextIt[2])/currIt[3])*100
                ;msgbox criteria 1  %crit% - %questionNo%
                if (((currIt[2]-nextIt[2])/currIt[3])*100 > 0) {
                    crit2 := currIt[3]-((currIt[2]-nextIt[2])/currIt[3])*100
                   msgbox criteria 2 %interval% > %crit2%
                if (interval > currIt[3]-((currIt[2]-nextIt[2])/currIt[3])*100) {
                modifier := currIt[3]-((currIt[2]-nextIt[2])/currIt[3])*100
                if (modifier < 1) {
                  modifier = 1
                }
                msgbox changing to %modifier% instead of %interval%
                interval := modifier
                } 
                }
            }
            }

            if (quality <= 2) {
                tempdate := questionStats[1]
                tempnewdate := questionStats[2]
                tempease := questionStats[3]
                tempiteration := questionStats[4]
                tempinterval := questionStats[5]
                temprelations := questionStats[7]
                tempQuestionSav := questionStats[9]
                tempAnswerSav := questionStats[10]
                FileAppend , %tempdate%_%tempnewdate%_%tempease%_%tempiteration%_%tempinterval%_1_%temprelations%_0_%tempQuestionSav%_%tempAnswerSav% `n, qStat.dat
                sleep 200
                FileAppend , %questionVar% `n%answerVar% `n, toRemember.dat
                ;msgbox %tempdate%_%tempnewdate%_%tempease%_%tempiteration%_%tempinterval%_1_%temprelations%_0 `n, qStat.dat
            }

            iteration := questionStats[4] + 1
            isActive := questionStats[6]
            relations := questionStats[7]
            importance := questionStats[8]
            questionSav := questionStats[9]
            answerSav := questionStats[10]
            FormatTime , Current, , yyyyMMddHHmmss
                        NextDate := NewDate(interval)

            lineNum := iteration -1
            ;msgbox %lineNum%
            FileReadLine , averageVar, averages.dat, lineNum
            if (ErrorLevel) {
                newAverage = %lineNum%_%easeFactor%_%interval%_1_%interval%_%easeFactor%`n
                FileAppend , %newAverage%, averages.dat
            } else {
                averageItem := StrSplit(averageVar, "_")
                totalQuestionsAverage := averageItem[4]+1
                totalIntervalsAverage := averageItem[5]+interval
                totalEaseAverage := averageItem[6]+easeFactor
                easeAverage := totalEaseAverage/totalQuestionsAverage
                intervalAverage := totalIntervalsAverage/totalQuestionsAverage
                newAverage = %lineNum%_%easeAverage%_%intervalAverage%_%totalQuestionsAverage%_%totalIntervalsAverage%_%totalEaseAverage%
                FileRead , filecontent2, averages.dat
                StringReplace , filecontent2, filecontent2, %averageVar%, %newAverage%
                FileDelete , averages.dat
                FileAppend , %filecontent2%, averages.dat
            }
      


            FormatTime , NextDate, %NextDate%, yyyyMMdd
            newStats = %Current%_%NextDate%000000_%easeFactor%_%iteration%_%interval%_%isActive%_%relations%_%importance%_%questionSav%_%answerSav%

            FileRead , filecontent, qStat.dat
            StringReplace , filecontent, filecontent, %questionStat%, %newStats%
            FileDelete , qStat.dat
            FileAppend , %filecontent%, qStat.dat
            sleep 200
        } else {
            if (quality <= 2) {
                tempdate := questionStats[1]
                tempnewdate := questionStats[2]
                tempease := questionStats[3]
                tempiteration := questionStats[4]
                tempinterval := questionStats[5]
                temprelations := questionStats[7]
                   tempQuestionSav := questionStats[9]
                tempAnswerSav := questionStats[10]
                FileAppend , %tempdate%_%tempnewdate%_%tempease%_%tempiteration%_%tempinterval%_1_%temprelations%_0_%tempQuestionSav%_%tempAnswerSav% `n, qStat.dat
                sleep 200
                FileAppend , %questionVar% `n%answerVar% `n, toRemember.dat
                ;msgbox ask again later
                ;msgbox %tempdate%_%tempnewdate%_%tempease%_%tempiteration%_%tempinterval%_1_%temprelations%_0 `n, qStat.dat
            }
            sleep 200
            FileLineDelete("toRemember.dat", questionNo * 2 - 1, 2)
            sleep 200
            FileLineDelete("qStat.dat", questionNo, 1)
        }
        Iterator()
        return
    }

    ;interval = I(1) = 1, I(2)= 6, for n>2 then I(n)=I(n-1)*EF(e factor)
    ;new e-factor = old e-factor+(0.1-5(5-qualit of response)*(0.08+(5-quality of response)*0.02))
    ;if e-factor less than 1.3 then let it be 1.3
    ;if quality < 3 then I(n) = I(1) as if you were starting again.
    ;if quality < 4 then add it back to the queue for that day until it is at least a 4
    ;0 black out - 5 perfection

GuiClose:
    ExitApp

    FileLineDelete(_FileName, _LineNum = 1, _LineCount = 1)
    {
        FileRead , FileContent, %_FileName%
        Loop , Parse, FileContent, `n, `r
        {
            If (A_Index >= _LineNum AND _LineCount > 0)
            {
                _LineCount--
                Continue
            } Else
            if (A_LoopField != "") {
                FileNewContent .= A_LoopField . "`r`n"
            }
        }
        FileDelete , %_FileName%
        FileAppend , %FileNewContent%, %_FileName%
        Return 0
    }