#SingleInstance, Force
CoordMode, Pixel, Screen
SendMode, Input
SetDefaultMouseSpeed, 5

; global variables ;

RetryDelay := 10000                             ; 10 seconds
ShortDelay := 200                               ; delay used on kepresses or waiting on time-sensitive functions to execute
FormatTime, CurrentDateTime,, dd-MM-yy HH:mm    ; store date and time at start of the script
LogsFolder := Event.log                         ; SET ON DESTINATION MACHINE - position of the system logs

; subroutines ;

; find image on screen and click it
FindAndClick( ByRef Success, X1, Y1, X2, Y2, image ){
    WinActivate, ahk_exe Discord.exe
    ImageSearch, OutX, OutY, X1, Y1, X2, Y2, %image%
    if (ErrorLevel = 2){
        MsgBox, 0, Error, Could not conduct the search, 1
        log( "Could not conduct the search" )
        ExitApp
    }
    else if (ErrorLevel = 1){
        ;MsgBox, 0, Error, Icon could not be found on the screen. %image%, 1
        Success := 0
    }
    else{
        ;MsgBox The icon was found at %OutX%x%OutY%. 
        CoordMode, Mouse
        MouseMove, OutX+5, OutY+5
        Sleep, 350
        Click, Left
        Sleep, 350
        
        CoordMode, Pixel
        Success := 1
    }
}

log( string ){
    FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm:ss
    FileAppend, %CurrentDateTime% - %string% `n, %LOGSFOLDER%
}

; init ;

Process, Exist, Discord.exe
if (ErrorLevel = 0){
    MsgBox, Discord is not active
    ExitApp
}

WinActivate ahk_exe Discord.exe
WinMaximize ahk_exe Discord.exe

log( "script init" )

MsgBox, 0, INIT, Discord midjurney request monitoring script. Looking For Message, 2
Sleep, 3500

; MAIN LOOP ;

Loop{
    WinActivate ahk_exe Discord.exe

    FindAndClick( Success, 80, 80, 250, 1000, "images\LiveButton.png")

    Sleep, RetryDelay
}

; POOL NIAM ;

; emergency stop ctrl+esc
^Esc::
    MsgBox, Emergency Exit Combination Pressed
    log( "force stop")
    ExitApp
Return